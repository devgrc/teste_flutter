import 'package:flutter/material.dart';
import '../../common/app_text_styles.dart';
import '../../common/constants/routes.dart';
import 'saldo_controller.dart';
import 'saldo_state.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({super.key});

  @override
  _SaldoPageState createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  final SaldoController _controller = SaldoController();
  final TextEditingController _addSaldoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.fetchSaldo(); // Busca o saldo ao iniciar a página
  }

  @override
  void dispose() {
    _controller.dispose();
    _addSaldoController.dispose();
    super.dispose();
  }

  void _submitAddSaldo() {
    final String? value = _addSaldoController.text;
    if (value != null && value.isNotEmpty) {
      final double saldoToAdd = double.tryParse(value) ?? 0.0;
      if (saldoToAdd > 0) {
        // Aqui você deve implementar a lógica para adicionar o saldo
        _controller.addSaldo(saldoToAdd);
        _addSaldoController.clear(); // Limpa o campo após adicionar
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<SaldoState>(
        stream: _controller.state,
        builder: (context, snapshot) {
          if (snapshot.data is SaldoStateLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003617)),
              ),
            );
          } else if (snapshot.data is SaldoStateError) {
            final errorState = snapshot.data as SaldoStateError;
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
                      child: Column(
                        children: [
                          const SizedBox(height: 25.0),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Adicionar Saldo',
                              style: AppTextStyles.KantumLogin1,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Digite o valor que deseja adicionar à sua conta!',
                              style: AppTextStyles.KantumLogin2,
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          TextFormField(
                            controller: _addSaldoController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Valor',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelStyle: TextStyle(color: Color.fromARGB(209, 255, 255, 255)),
                              hintText: 'Insira o valor a adicionar',
                              hintStyle: TextStyle(color: Color.fromARGB(103, 255, 255, 255)),
                              prefixIcon: Icon(Icons.attach_money, color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Center(
                            child: SizedBox(
                              width: 335.32,
                              height: 59.0,
                              child: ElevatedButton(
                                onPressed: _submitAddSaldo,
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
                          const SizedBox(height: 20.0),
                          if (snapshot.data is SaldoStateLoaded) 
                            _buildSaldoDisplay(snapshot.data as SaldoStateLoaded),
                          const SizedBox(height: 16.0),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, NamedRoutes.home);
                            },
                            child: const Text(
                              'Voltar para Home',
                              style: AppTextStyles.KodchasanLogin,
                            ),
                          ),
                        ],
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

  Widget _buildSaldoDisplay(SaldoStateLoaded saldoState) {
    return Text(
      'Saldo Atual: R\$ ${saldoState.saldo.valor.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 24, color: Colors.white),
    );
  }
}
