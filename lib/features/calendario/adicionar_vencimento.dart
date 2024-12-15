import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/features/categorias/categorias_state.dart';
import 'package:teste_flutter/utils/sizes.dart'; // Importe a classe Sizes

class AdicionarVencimentoPage extends StatefulWidget {
  final DateTime selectedDay;
  final Function(Map<String, dynamic>) onVencimentoAdded;

  const AdicionarVencimentoPage({
    Key? key,
    required this.selectedDay,
    required this.onVencimentoAdded,
  }) : super(key: key);

  @override
  _AdicionarVencimentoPageState createState() => _AdicionarVencimentoPageState();
}

class _AdicionarVencimentoPageState extends State<AdicionarVencimentoPage> {
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  bool _isNewCategory = false;
  String? _selectedCategory;
  String _tipo = 'Despesa';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Sizes.init(context); // Inicializa a classe Sizes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Vencimento'),
        titleTextStyle: AppTextStyles.KodchasanAddTandaction,
        backgroundColor: const Color(0xFF003617),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0x00b8efcb).withOpacity(0.3), // Cor de fundo adicionada
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.description, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(
                  labelText: 'Valor',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.attach_money, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
                                    : const Color(0xFF003617)
                                        .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Usar Categoria Existente',
                                style: TextStyle(
                                  color: _isNewCategory
                                      ? const Color.fromARGB(255, 120, 120, 120)
                                      : const Color(0xFF003617),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
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
                                    ? const Color(0xFF003617)
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Criar Nova Categoria',
                                style: TextStyle(
                                  color: _isNewCategory
                                      ? const Color(0xFF003617)
                                      : const Color.fromARGB(255, 113, 113, 113),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
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
                            labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.category, color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
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
                          decoration: InputDecoration(
                            labelText: 'Nova Categoria',
                            labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.category, color: const Color.fromARGB(255, 0, 0, 0)),
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
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _tipo,
                onChanged: (newValue) {
                  setState(() {
                    _tipo = newValue!;
                  });
                },
                items: <String>['Despesa', 'Receita']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.attach_money, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione o tipo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final descricao = _descricaoController.text;
                      final valor = double.tryParse(_valorController.text) ?? 0.0;
                      final categoria = _isNewCategory
                          ? _categoriaController.text
                          : _selectedCategory;

                      if (descricao.isNotEmpty && valor > 0 && categoria != null && categoria.isNotEmpty) {
                        final vencimento = {
                          'descricao': descricao,
                          'valor': valor,
                          'categoria': categoria,
                          'tipo': _tipo,
                        };

                        if (_isNewCategory) {
                          // Adiciona a nova categoria ao CategoryProvider
                          Provider.of<CategoryProvider>(context, listen: false).addCategory(
                            Category(name: categoria, icon: Icons.category), // Substitua pelo ícone apropriado
                          );
                        }

                        widget.onVencimentoAdded(vencimento);
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor, preencha todos os campos corretamente.'),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF003617),
                    minimumSize: Size(375.w, 58.h), // Largura de 375 e altura de 58
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
