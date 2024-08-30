import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

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
                    color: Color(0xFF3D9673),
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
                              onPressed: () {},
                              child: const Text(
                                'Comece Agora!',
                                style: AppTextStyles.KodchasanButton,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Center(
                          child: Text(
                            'Já tem uma conta? Faça Login!',
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
          Positioned(
            top: 55.0, // Ajuste a posição conforme necessário
            left: 15.0,
            child: Image.asset(
              'assets/images/brazuca.png', // Substitua pelo caminho da sua imagem
              width: 150.0, // Ajuste o tamanho conforme necessário
              height: 150.0, // Ajuste o tamanho conforme necessário
            ),
          ),
        ],
      ),
    );
  }
}
