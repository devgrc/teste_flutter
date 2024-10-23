import 'package:flutter/material.dart';

class AddReceitaDespesa extends StatefulWidget {
  const AddReceitaDespesa({super.key});

  @override
  _AddReceitaDespesaState createState() => _AddReceitaDespesaState();
}

class _AddReceitaDespesaState extends State<AddReceitaDespesa> {
  final _formKey = GlobalKey<FormState>();
  String _tipo = 'Receita';
  late String _descricao;
  late double _valor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Receita/Despesa'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _tipo,
              onChanged: (value) {
                setState(() {
                  _tipo = value!;
                });
              },
              items: ['Receita', 'Despesa'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma descrição';
                }
                return null;
              },
              onSaved: (value) {
                _descricao = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um valor';
                }
                return null;
              },
              onSaved: (value) {
                _valor = double.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Adicionar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Aqui você pode adicionar a lógica para salvar a receita ou despesa
              print('Tipo: $_tipo');
              print('Descrição: $_descricao');
              print('Valor: $_valor');
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
