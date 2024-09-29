import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/common/constants/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false; // Variável para controlar o carregamento

  InputDecoration buildInputDecoration(String labelText, String hintText,
      Widget? prefixIcon, Widget? suffixIcon) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(
          color: Color.fromARGB(209, 255, 255, 255)), // Cor da etiqueta
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color.fromARGB(103, 255, 255, 255)), // Cor da dica (hint)
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(
                0xFFAFAFAF)), // Cor da borda quando o campo não está em foco
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(0xFFE4E4E4),
            width: 2.0), // Cor e largura da borda quando o campo está em foco
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Inicia o carregamento
      });

      // Simula uma requisição de cadastro e, após 2 segundos, navega para a próxima tela
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false; // Termina o carregamento
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(), // Tela principal (ainda não pronta)
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003617)),
          ),
          ) // Mostra o carregamento
          : Column(
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
                              const SizedBox(height: 20.0),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Cadastro',
                                  style: AppTextStyles.KantumLogin1,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Efetue o seu Cadastro!',
                                  style: AppTextStyles.KantumLogin2,
                                ),
                              ),
                              const SizedBox(height: 40.0),
                              // Campos de formulário e validações
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                decoration: buildInputDecoration(
                                  'Nome',
                                  'Insira seu nome',
                                  const Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 255, 255, 255), 
                                  ),
                                  null,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu nome';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: buildInputDecoration(
                                  'Email',
                                  'Insira seu email',
                                  const Icon(
                                    Icons.email,
                                    color: Color.fromARGB(255, 255, 255, 255), 
                                  ),
                                  null,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu email';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Por favor, insira um email válido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: _passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: !_isPasswordVisible,
                                decoration: buildInputDecoration(
                                  'Senha',
                                  'Insira sua senha',
                                  const Icon(
                                    Icons.password, 
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
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
                                onChanged: (value) {
                                  _confirmPasswordController.text = value;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: _confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: !_isConfirmPasswordVisible,
                                decoration: buildInputDecoration(
                                  'Confirme sua Senha',
                                  'Confirme sua senha',
                                  const Icon(
                                    Icons.password,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isConfirmPasswordVisible =
                                            !_isConfirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, confirme sua senha';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'As senhas não coincidem';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 70.0),
                              Center(
                                child: SizedBox(
                                  width: 335.32,
                                  height: 59.0,
                                  child: ElevatedButton(
                                    onPressed: _submitForm, // Aciona o carregamento e a navegação
                                    style: ElevatedButton.styleFrom(
                                      elevation: 6,
                                      shadowColor: Colors.black,
                                    ),
                                    child: const Text(
                                      'Cadastro',
                                      style: AppTextStyles.KantumruyButton,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, NamedRoutes.login);
                                },
                                child: const Text(
                                  'Já tem uma conta? Faça Login!',
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
            ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tela Principal',
          style: AppTextStyles.KantumruyButton,
        ),
      ),
    );
  }
}
