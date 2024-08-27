import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class OnboardngPage extends StatelessWidget {
  const OnboardngPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 90.0), // Espaço antes do conteúdo principal
          Expanded(
            child: Container(
              height: 300.0, // Altura do container principal
              color: Color(0xFF3D9673), // Cor de fundo do container
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 34.0), // Define o espaçamento lateral
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centraliza verticalmente os widgets na coluna
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinha os widgets à esquerda
                  children: [
                    const Align(
                      alignment: Alignment
                          .centerLeft, // Alinha o texto à esquerda dentro do alinhamento
                      child: Text(
                        'Nunca é tarde para organizar sua vida financeira.',
                        style: AppTextStyles.KodchasanOnBoarding,
                        textAlign: TextAlign
                            .left, // Alinha o texto à esquerda no espaço disponível
                      ), 
                    ), 
                    const SizedBox(
                        height: 200.0), // Espaço entre o texto e o botão
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
                    const SizedBox(
                        height: 16.0), // Espaço entre o botão e o texto pequeno
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
    ); 
  }
}
