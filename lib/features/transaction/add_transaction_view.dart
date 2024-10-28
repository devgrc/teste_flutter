import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/features/home/home_controller.dart';

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _categoriaController = TextEditingController();
  String _tipo = 'Receita';
  DateTime _data = DateTime.now();
  IconData? _selectedIcon; // Campo para armazenar o ícone selecionado

  // Método para exibir um seletor de ícones
  void _selectIcon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Escolha um Ícone'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lista de ícones disponíveis
                ...[ 
                  Icons.attach_money,
                  Icons.arrow_upward,
                  Icons.arrow_downward,
                  Icons.shopping_cart,
                  Icons.paid,
                  // Adicione mais ícones conforme necessário
                ].map((icon) {
                  return IconButton(
                    icon: Icon(icon),
                    onPressed: () {
                      setState(() {
                        _selectedIcon = icon; // Armazena o ícone selecionado
                      });
                      Navigator.pop(context);
                    },
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
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: 'Categoria'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a categoria';
                  }
                  return null;
                },
              ),
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
                    child: Text(tipo),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              // Exibição do ícone selecionado e botão para escolher um novo
              GestureDetector(
                onTap: () => _selectIcon(context),
                child: Row(
                  children: [
                    Icon(_selectedIcon ?? Icons.monetization_on), // Exibe o ícone selecionado ou um ícone padrão
                    SizedBox(width: 8),
                    Text('Escolha um ícone'),
                  ],
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: DateFormat('dd/MM/yyyy').format(_data)),
                decoration: InputDecoration(labelText: 'Data'),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _data,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null && selectedDate != _data) {
                    setState(() {
                      _data = selectedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nome = _nomeController.text;
                    final valor = double.parse(_valorController.text);
                    final categoria = _categoriaController.text;
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
                      icon: _selectedIcon ?? Icons.monetization_on, // Armazenar o ícone selecionado ou um padrão
                    );

                    context.read<HomeController>().addReceitaDespesa(transaction);
                    Navigator.pop(context);
                  }
                },
                child: Text('Adicionar Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
