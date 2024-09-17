import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/features/login/login_page.dart';
import 'package:teste_flutter/features/sign_up/sign_up_page.dart'; // Certifique-se de importar a página de login

class OnboardngPage extends StatelessWidget {
  const OnboardngPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              const SizedBox(height: 150.0),
              Expanded(
                child: Container(
                  height: 300.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF003617),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55.0),
                      topRight: Radius.circular(55.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80.0),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nunca é tarde para organizar sua vida financeira.',
                            style: AppTextStyles.KodchasanOnBoarding,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 90.0),
                        Center(
                          child: SizedBox(
                            width: 335.32,
                            height: 59.0,
                            child: ElevatedButton(
                              onPressed: () {
                                // Substitui a página atual pela SignUpPage ao pressionar "Comece Agora"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Comece Agora!',
                                style: AppTextStyles.KodchasanButton,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        InkWell(
                          onTap: () {
                            // Substitui a página atual pela LoginPage ao pressionar "Faça Login!"
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: const Center(
                            child: Text(
                              'Já tem uma conta? Faça Login!',
                              style: AppTextStyles.KodchasanLogin,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 55.0,
            left: 15.0,
            child: Image.asset(
              'assets/images/brazuca.png',
              width: 150.0,
              height: 150.0,
            ),
          ),
        ],
      ),
    );
  }
}
