import 'package:flutter/material.dart';
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nome = _nomeController.text;
                    final valor = double.parse(_valorController.text);
                    final categoria = _categoriaController.text;
                    final tipo = _tipo;
                    final data = DateTime.now();
                    final isCredit = tipo == 'Receita';

                    final transaction = ReceitaDespesa(
                      nome: nome,
                      valor: valor,
                      tipo: tipo,
                      categoria: categoria,
                      data: data,
                      isCredit: isCredit,
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
