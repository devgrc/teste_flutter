import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'dart:convert';
import 'package:teste_flutter/features/calendario/adicionar_vencimento.dart';
import 'package:teste_flutter/features/home/home_controller.dart';
import 'package:teste_flutter/utils/sizes.dart'; // Importe a classe Sizes

class CalendarioPage extends StatefulWidget {
  final HomeController homeController;

  const CalendarioPage({super.key, required this.homeController});

  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  // Controle da data selecionada
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Mapa que armazena os vencimentos por data
  final Map<DateTime, List<Map<String, dynamic>>> _vencimentosPorData = {};

  @override
  void initState() {
    super.initState();
    _carregarVencimentos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Sizes.init(context); // Inicializa a classe Sizes
  }

  // Função para carregar vencimentos do SharedPreferences
  Future<void> _carregarVencimentos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vencimentosJson = prefs.getString('vencimentos');
    if (vencimentosJson != null) {
      Map<String, dynamic> vencimentosMap = json.decode(vencimentosJson);
      vencimentosMap.forEach((key, value) {
        DateTime date = DateTime.parse(key);
        List<Map<String, dynamic>> vencimentos = List<Map<String, dynamic>>.from(value);
        _vencimentosPorData[date] = vencimentos;
      });
      setState(() {});
    }
  }

  // Função para salvar vencimentos no SharedPreferences
  Future<void> _salvarVencimentos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> vencimentosMap = {};
    _vencimentosPorData.forEach((key, value) {
      vencimentosMap[key.toIso8601String()] = value;
    });
    String vencimentosJson = json.encode(vencimentosMap);
    await prefs.setString('vencimentos', vencimentosJson);
  }

  // Função para adicionar vencimento
  void _adicionarVencimento() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdicionarVencimentoPage(
          selectedDay: _selectedDay,
          onVencimentoAdded: (vencimento) {
            setState(() {
              if (!_vencimentosPorData.containsKey(_selectedDay)) {
                _vencimentosPorData[_selectedDay] = [];
              }
              _vencimentosPorData[_selectedDay]!.add(vencimento);
            });
            _salvarVencimentos(); // Salva os vencimentos no SharedPreferences
          },
        ),
      ),
    );
  }

  // Função para excluir um vencimento
  void _excluirVencimento(DateTime date, int index) {
    setState(() {
      _vencimentosPorData[date]!.removeAt(index);
      if (_vencimentosPorData[date]!.isEmpty) {
        _vencimentosPorData.remove(date);
      }
    });
    _salvarVencimentos(); // Salva os vencimentos no SharedPreferences
  }

  // Função para verificar se uma data contém vencimentos
  List<Map<String, dynamic>> _getVencimentosParaData(DateTime date) {
    return _vencimentosPorData[date] ?? [];
  }

  // Função para atualizar o status de pagamento de um vencimento
  void _atualizarStatusPagamento(DateTime date, int index, bool isPago) {
    setState(() {
      final vencimento = _vencimentosPorData[date]![index];
      bool isDespesa = vencimento['tipo'] == 'Despesa';
      double valor = vencimento['valor'];

      // Atualiza a flag 'isPago' do vencimento
      vencimento['isPago'] = isPago;

      // Atualiza o saldo e o histórico de transações no HomeController
      widget.homeController.updateBalanceAndHistoricoForVencimento(vencimento, isPago);
    });
    _salvarVencimentos(); // Salva os vencimentos no SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
        titleTextStyle: AppTextStyles.KodchasanAddTandaction,
        backgroundColor: const Color(0xFF003617),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0x00b8efcb).withOpacity(0.3), // Cor de fundo adicionada
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: (day) {
                // Retorna a lista de vencimentos para a data
                return _vencimentosPorData[day] ?? [];
              },
              calendarStyle: CalendarStyle(
                markersMaxCount: 99, // Permite múltiplos marcadores por data
                markerDecoration: BoxDecoration(
                  color: Colors.red, // Cor da bolinha
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFF003617), // Cor de seleção de data
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 227, 137), // Cor de hoje
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: const Color(0xFF003617),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              locale: Localizations.localeOf(context).languageCode, // Define o idioma para português
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _getVencimentosParaData(_selectedDay).length,
                itemBuilder: (context, index) {
                  final vencimento = _getVencimentosParaData(_selectedDay)[index];
                  bool isPago = vencimento['isPago'] ?? false;
                  bool isDespesa = vencimento['tipo'] == 'Despesa';

                  return Column(
                    children: [
                      Container(
                        width: 369.w, // Largura do container ajustada
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // altera a posição da sombra
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isDespesa ? Icons.arrow_downward : Icons.arrow_upward,
                                  color: isDespesa ? Colors.red : Colors.green,
                                ), // Ícone de transferência
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vencimento['descricao'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${vencimento['categoria']} - ${vencimento['tipo']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Valor
                            Text(
                              'R\$ ${vencimento['valor'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: isPago ? Colors.green : (isDespesa ? Colors.red : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Checkbox e botão de excluir
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 144.w, // Largura fixa
                            height: 48.h, // Altura fixa
                            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 23.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // altera a posição da sombra
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: isPago,
                                    onChanged: (value) {
                                      _atualizarStatusPagamento(_selectedDay, index, value!);
                                    },
                                    activeColor: Colors.green,
                                  ),
                                  Text(
                                    isDespesa ? 'Pago' : 'Recebido',
                                    style: TextStyle(
                                      color: isPago ? Colors.green : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 144.w, // Largura fixa
                            height: 48.h, // Altura fixa
                            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 23.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // altera a posição da sombra
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _excluirVencimento(_selectedDay, index);
                                    },
                                  ),
                                  Text(
                                    'Excluir',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Botão de adicionar no canto inferior direito
      floatingActionButton: Align(
        alignment: Alignment.bottomRight, // Posiciona o botão no canto inferior direito
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: _adicionarVencimento,
            tooltip: 'Adicionar Vencimento',
            backgroundColor: const Color(0xFF003617), // Cor do botão
            foregroundColor: Colors.white, // Cor do ícone
            elevation: 5.0, // Sombra do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas
            ),
            mini: false, // Chama a tela de adição de vencimento
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
