import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'sign_up_controller.dart';
import 'sign_up_state.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController controller = SignUpController();

  @override
  void initState() {
    super.initState();
    
    // Adicione um listener ao controller da senha
    controller.passwordController.addListener(() {
      controller.confirmPasswordController.text = controller.passwordController.text;
    });
  }

  @override
  void dispose() {
    // Remova o listener ao descartar o estado
    controller.passwordController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: builder(context),
    );
  }

  Widget builder(BuildContext context) {
    if (controller.state is SignUpStateLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003617)),
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
                  key: controller.formKey,
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
                      // Campos de formulário
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Color.fromARGB(209, 255, 255, 255)),
                          hintText: 'Insira seu nome',
                          hintStyle: TextStyle(color: Color.fromARGB(103, 255, 255, 255)),
                          prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
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
                        style: const TextStyle(color: Colors.white),
                        controller: controller.passwordController,
                        textInputAction: TextInputAction.next,
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
                      const SizedBox(height: 20.0),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: controller.confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirme sua Senha',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Color.fromARGB(209, 255, 255, 255)),
                          hintText: 'Confirme sua senha',
                          hintStyle: TextStyle(color: Color.fromARGB(103, 255, 255, 255)),
                          prefixIcon: Icon(Icons.password, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirme sua senha';
                          }
                          if (value != controller.passwordController.text) {
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
                            onPressed: () {
                              controller.submitForm(() {
                                // Chama a navegação para a home
                                Navigator.pushReplacementNamed(context, NamedRoutes.home);
                              });
                              setState(() {
                                // Atualiza o estado após chamar a função
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 6,
                              backgroundColor: const Color(0xFFD9D9D9),
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
    );
  }
}
