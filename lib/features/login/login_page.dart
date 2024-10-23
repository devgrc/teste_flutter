import 'package:flutter/material.dart';
import '../../common/app_text_styles.dart';
import '../../common/constants/routes.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginController _controller = LoginController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _controller.submitForm(
        _emailController.text,
        _passwordController.text,
        () {
          // Navegação para a AddSaldoPage após o sucesso do login
          Navigator.pushReplacementNamed(context, NamedRoutes.addSaldo);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<SignInState>(
        stream: _controller.state,
        builder: (context, snapshot) {
          if (snapshot.data is SignInStateLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003617)),
              ),
            );
          } else if (snapshot.data is SignInStateError) {
            final errorState = snapshot.data as SignInStateError;
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
                                'Login',
                                style: AppTextStyles.KantumLogin1,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Faça o Login para continuar!',
                                style: AppTextStyles.KantumLogin2,
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Color.fromARGB(209, 255, 255, 255)),
                                hintText: 'Insira seu email',
                                hintStyle: TextStyle(color: Color.fromARGB(103, 255, 255, 255)),
                                prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Por favor, insira um email válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Color.fromARGB(209, 255, 255, 255)),
                                hintText: 'Insira sua senha',
                                hintStyle: TextStyle(color: Color.fromARGB(103, 255, 255, 255)),
                                prefixIcon: Icon(Icons.password, color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                if (value.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 50.0),
                            Center(
                              child: SizedBox(
                                width: 335.32,
                                height: 59.0,
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 6,
                                    shadowColor: Colors.black,
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: AppTextStyles.KantumruyButton,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, NamedRoutes.signUp);
                              },
                              child: const Text(
                                'Não tem uma conta? Cadastre-se!',
                                style: AppTextStyles.KodchasanLogin,
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
