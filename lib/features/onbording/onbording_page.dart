import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teste_flutter/common/app_text_styles.dart';

class OnboardngPage extends StatelessWidget {
  const OnboardngPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Expanded(
          child: Container(
            height: 300.0,
            color: Color(0xFF3D9673),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),  // Define o espaçamento lateral
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,  // Centraliza verticalmente os widgets na coluna
                crossAxisAlignment: CrossAxisAlignment.start,  // Alinha os widgets à esquerda
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,  // Alinha o texto à esquerda dentro do alinhamento
                    child: Text(
                      'Nunca é tarde para organizar sua vida financeira.', 
                      style: AppTextStyles.KodchasanOnBoarding,
                      textAlign: TextAlign.left,  // Alinha o texto à esquerda no espaço disponível
                    ),
                  ),
                  const SizedBox(height: 200.0),  // Espaço entre o texto e o botão
                  Center(child:ElevatedButton(
                    onPressed: () {
                      // Ação quando o botão é pressionado
                    },
                    child: const Text('Comece Agora!'),
                  ),
                  ),
                  
                  const SizedBox(height: 16.0),  // Espaço entre o botão e o texto pequeno
                  const Center(
                    child:Text(
                    'Já tem uma conta? Faça Login!',
                    style: TextStyle(
                      color: Colors.white,  // Ajuste a cor do texto conforme necessário
                      fontSize: 18.0,  // Ajuste o tamanho da fonte conforme necessário
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
  );
}


}