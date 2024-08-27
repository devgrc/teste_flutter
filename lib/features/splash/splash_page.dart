import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primalWhite,
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 252,
          height: 237,
        ),
      ),
    );
  }
}