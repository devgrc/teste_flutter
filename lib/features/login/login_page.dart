import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  InputDecoration buildInputDecoration(String labelText, String hintText) {
    return InputDecoration(
    labelText: labelText,
    border: const OutlineInputBorder(),
    labelStyle: const TextStyle(
        color: Color.fromARGB(209, 55, 55, 55)), // Cor da etiqueta
    hintText: hintText,
    hintStyle: const TextStyle(
        color: Color.fromARGB(103, 0, 0, 0)), // Cor da dica (hint)
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFFE4E4E4)), // Cor da borda quando o campo não está em foco
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Color.fromARGB(180, 0, 0, 0),
          width: 2.0), // Cor e largura da borda quando o campo está em foco
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 151.0,
              width: 138.0,
            ),
          ),
          Expanded(
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                color: Color(0xFF3D9673),
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
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Seja Bem Vindo',
                        style: AppTextStyles.KantumLogin1,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Efetue o seu Login!',
                        style: AppTextStyles.KantumLogin2,
                      ),
                    ),
                    
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: buildInputDecoration('Nome','Digite seu email')
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: buildInputDecoration('Senha', 'Insira sua senha')
                    ),
                    const SizedBox(height: 70.0),
                    Center(
                      child: SizedBox(
                        width: 335.32,
                        height: 59.0,
                        child: ElevatedButton(
                          onPressed: () => log('Botão "Cadastro" pressionado'),
                          style: ElevatedButton.styleFrom(
                            elevation: 6,
                            shadowColor: Colors.black,
                          ),
                          child: const Text(
                            'Login',
                            style: AppTextStyles.KodchasanButton,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () => log('Botão "Login" pressionado'),
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
        ],
      ),
    );
  }
}
