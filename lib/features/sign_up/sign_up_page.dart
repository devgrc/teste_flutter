import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                        'Efetue o seu Cadastro!',
                        style: AppTextStyles.KantumLogin2,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Insira o seu Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Insira o seu Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Insira a sua Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Confirme a sua Senha',
                        border: OutlineInputBorder(),
                      ),
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
                            'Cadastro',
                            style: AppTextStyles.KodchasanButton,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () => log('Botão "Cadastre-se" pressionado'),
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
        ],
      ),
    );
  }
}
