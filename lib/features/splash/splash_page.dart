import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/app_colors.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'package:teste_flutter/features/onbording/onbording_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init(); 
  }

  Timer init() {
    return Timer(
      const Duration(seconds: 2),
      navigateToOnbording,
    );
  }

  void navigateToOnbording() {
    Navigator.pushReplacementNamed(
        context,
        NamedRoutes.initial
        );
  }

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
