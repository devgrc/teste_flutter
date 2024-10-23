import 'package:flutter/material.dart';
import 'package:teste_flutter/features/home/home_controller.dart';
import '../../common/app_text_styles.dart';
import '../../common/constants/routes.dart';
import 'add_saldo_controller.dart';
import 'add_saldo_state.dart';

class AddSaldoPage extends StatefulWidget {
  final HomeController homeController;

  const AddSaldoPage({required this.homeController, super.key});

  @override
  _AddSaldoPageState createState() => _AddSaldoPageState();
}

class _AddSaldoPageState extends State<AddSaldoPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  late final AddSaldoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AddSaldoController(widget.homeController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _controller.submitForm(
        _amountController.text,
        () {
          // Navegação para a HomePage após o sucesso
          Navigator.pushReplacementNamed(context, NamedRoutes.home);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AddSaldoState>(
        stream: _controller.state,
        builder: (context, snapshot) {
          if (snapshot.data is AddSaldoStateLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003617)),
              ),
            );
          } else if (snapshot.data is AddSaldoStateError) {
            final errorState = snapshot.data as AddSaldoStateError;
            return Center(
              child: Text(
                errorState.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Column(
            children: [
              const SizedBox(height: 15.0),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 151.0,
                  width: 138.0,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF003617),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55.0),
                      topRight: Radius.circular(55.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 25.0),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Seu Saldo',
                                style: AppTextStyles.KantumLogin1,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Chegou a hora de adicionar o seu dinheiro.\n' 
                                'Ex: salário, mesada, aposentadoria, etc.',
                                style: AppTextStyles.SubSaldo,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            TextFormField(
                              controller: _amountController,
                              style: const TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Valor',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Color.fromARGB(209, 255, 255, 255)),
                                hintText: 'Insira o valor',
                                hintStyle: TextStyle(color: Color.fromARGB(103, 255, 255, 255)),
                                prefixIcon: Icon(Icons.attach_money, color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o valor';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Por favor, insira um valor válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 50.0),
                            Center(
                              child: SizedBox(
                                width: 375.0,
                                height: 58.0,
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 6,
                                    shadowColor: Colors.black,
                                  ),
                                  child: const Text(
                                    'Adicionar Saldo',
                                    style: AppTextStyles.KantumruyButton,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
