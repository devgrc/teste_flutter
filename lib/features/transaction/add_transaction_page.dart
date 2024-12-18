import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/features/home/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importando o FontAwesome
import 'package:teste_flutter/features/categorias/categorias_state.dart'; // Importe o arquivo do provider
import 'package:teste_flutter/utils/sizes.dart'; // Importe o arquivo sizes

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _categoriaController = TextEditingController();
  String? _selectedCategory;
  String _tipo = 'Receita';
  DateTime _data = DateTime.now();
  IconData? _selectedIcon = FontAwesomeIcons.dollarSign; // Definir um ícone padrão
  bool _isNewCategory = false;

  // Função de escolha do ícone
  void _selectIcon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Escolha um Ícone', textAlign: TextAlign.center),
          content: SizedBox(
            width: 300, // Limitar a largura do diálogo
            height: 350, // Limitar a altura
            child: GridView.count(
              crossAxisCount: 4, // Número de colunas no grid
              crossAxisSpacing: 12, // Espaçamento horizontal entre os ícones
              mainAxisSpacing: 12, // Espaçamento vertical entre os ícones
              children: [
                ...[
                  Ionicons.cash, // Dinheiro
                  Ionicons.trending_up, // Tendência de Alta
                  Ionicons.trending_down, // Tendência de Baixa
                  Ionicons.swap_horizontal, // Transferência Horizontal
                  Ionicons.swap_vertical, // Transferência Vertical
                  Ionicons.receipt, // Recibo
                  Ionicons.wallet_outline, // Carteira Contorno
                  Ionicons.calculator, // Calculadora
                  Ionicons.cube, // Cubo (Investimento)
                  Ionicons.contract, // Contrato
                  Ionicons.wallet, // Cartera
                  Ionicons.card, // Cartão
                  Ionicons.cash, // Dinheiro
                  Ionicons.pizza, // Pizza
                  Ionicons.fast_food, // Fast Food
                  Ionicons.restaurant, // Restaurante
                  Ionicons.car, // Carro
                  Ionicons.bicycle, // Bicicleta
                  Ionicons.bus, // Ônibus
                  Ionicons.airplane, // Avião
                  Ionicons.train, // Trem
                  Ionicons.heart, // Coração
                  Ionicons.medical, // Médico
                  Ionicons.bed, // Cama
                  Ionicons.game_controller, // Controle de Jogo
                  Ionicons.gift, // Presente
                  Ionicons.camera, // Câmera
                  Ionicons.cart, // Carrinho de Compras
                  Ionicons.home, // Casa
                  Ionicons.phone_portrait, // Telefone
                  Ionicons.laptop, // Laptop
                  Ionicons.book, // Livro
                  Ionicons.headset, // Fone de Ouvido
                  Ionicons.wine, // Vinho
                  Ionicons.water, // Água
                  Ionicons.cog, // Engrenagem
                  Ionicons.briefcase, // Pasta
                  Ionicons.trophy, // Troféu
                  Ionicons.school, // Escola
                  Ionicons.earth, // Terra
                  Ionicons.flag, // Bandeira
                  Ionicons.ice_cream, // Sorvete
                  Ionicons.moon, // Lua
                  Ionicons.sunny, // Sol
                  Ionicons.leaf, // Folha
                  Ionicons.flower, // Flor
                ].map((icon) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon = icon;
                      });
                      Navigator.pop(context);
                    },
                    child: Icon(
                      icon,
                      size: 30,
                      color: _selectedIcon == icon ? Colors.blue : Colors.black,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003617), // Cor do fundo
      appBar: AppBar(
        title: const Text(
          'Adicionar Transação',
          style: AppTextStyles.KodchasanAddTandaction,
        ),
        centerTitle: true, // Título centralizado
        backgroundColor: const Color(0xFF003617), // Cor de fundo da AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Ícone de voltar branco
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nome Field
              TextFormField(
                controller: _nomeController,
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(209, 255, 255, 255)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Insira o nome',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(103, 255, 255, 255)),
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Valor Field
              TextFormField(
                controller: _valorController,
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  labelText: 'Valor',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(209, 255, 255, 255)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Insira o valor',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(103, 255, 255, 255)),
                  prefixIcon:
                      const Icon(Icons.attach_money, color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Categoria Dropdown ou TextField
              Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isNewCategory = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: _isNewCategory
                                    ? Colors.transparent
                                    : const Color.fromARGB(255, 114, 231, 184)
                                        .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Usar Categoria Existente',
                                style: TextStyle(
                                  color: _isNewCategory
                                      ? Colors.white
                                      : const Color.fromARGB(255, 33, 243, 128),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isNewCategory = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: _isNewCategory
                                    ? const Color.fromARGB(255, 114, 231, 184)
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Criar Nova Categoria',
                                style: TextStyle(
                                  color: _isNewCategory
                                      ? const Color.fromARGB(255, 33, 243, 128)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (!_isNewCategory)
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                          items: provider.categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.name,
                              child: Text(
                                category.name,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Categoria',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(209, 255, 255, 255)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Selecione a categoria',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(103, 255, 255, 255)),
                            prefixIcon:
                                const Icon(Icons.category, color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (provider.categories.isEmpty) {
                              return 'Nenhuma categoria criada';
                            }
                            if (value == null || value.isEmpty) {
                              return 'Por favor, selecione a categoria';
                            }
                            return null;
                          },
                        ),
                      if (_isNewCategory)
                        TextFormField(
                          controller: _categoriaController,
                          style: const TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Nova Categoria',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(209, 255, 255, 255)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Insira a nova categoria',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(103, 255, 255, 255)),
                            prefixIcon:
                                const Icon(Icons.category, color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a nova categoria';
                            }
                            return null;
                          },
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Tipo Dropdown
              DropdownButtonFormField<String>(
                value: _tipo,
                onChanged: (value) {
                  setState(() {
                    _tipo = value!;
                  });
                },
                items: ['Receita', 'Despesa'].map((String tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(
                      tipo,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(209, 255, 255, 255)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.h),

              // Icon Selection
              GestureDetector(
                onTap: () => _selectIcon(context),
                child: Row(
                  children: [
                    Icon(
                      _selectedIcon ??
                          FontAwesomeIcons
                              .dollarSign, // Exibindo o ícone selecionado
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Escolha um ícone',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Data Picker Field
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(
                      _data), // A data será formatada em português automaticamente
                ),
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Data',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(209, 255, 255, 255)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(103, 255, 255, 255)),
                  prefixIcon:
                      const Icon(Icons.calendar_today, color: Colors.white),
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _data,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: const Color(0xFF003617), // Cor da seleção das datas."
                            onPrimary: const Color.fromARGB(255, 255, 255, 255), // Cor dos números ao serem selecionados"
                            onSurface: const Color.fromARGB(255, 0, 0, 0), // Cor das datas
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF003617), // Cor do texto dos botões "OK" e "Cancelar"
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (selectedDate != null && selectedDate != _data) {
                    setState(() {
                      _data = selectedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 30.h),
              Center(
                child: SizedBox(
                  width: 335.32.w,
                  height: 59.0.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final nome = _nomeController.text;
                        final valor = double.parse(_valorController.text);
                        final categoria = _isNewCategory
                            ? _categoriaController.text
                            : _selectedCategory!;
                        final tipo = _tipo;
                        final data = _data;
                        final isCredit = tipo == 'Receita';

                        final transaction = ReceitaDespesa(
                          nome: nome,
                          valor: valor,
                          tipo: tipo,
                          categoria: categoria,
                          data: data,
                          isCredit: isCredit,
                          icon: _selectedIcon ?? FontAwesomeIcons.dollarSign,
                        );

                        context
                            .read<HomeController>()
                            .addReceitaDespesa(transaction);

                        // Adicionar a nova categoria automaticamente
                        if (_isNewCategory &&
                            _categoriaController.text.isNotEmpty) {
                          final newCategory = Category(
                            name: _categoriaController.text,
                            icon: _selectedIcon!,
                          );
                          context
                              .read<CategoryProvider>()
                              .addCategory(newCategory);
                        }

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Adicionar Transação',
                      style: AppTextStyles.KantumAddTandaction,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
