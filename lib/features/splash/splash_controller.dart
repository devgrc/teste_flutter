// lib/features/splash/splash_controller.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'splash_state.dart';

class SplashController {
  final Function(SplashState) updateState;
  final BuildContext context;

  SplashController(this.context, this.updateState);

  void init() {
    Timer(const Duration(seconds: 2), navigateToOnboarding);
  }

  void navigateToOnboarding() {
    // Aqui você pode determinar a lógica para verificar se o usuário está autenticado
    bool isAuthenticated = false; // Substitua pela sua lógica de autenticação

    // ignore: dead_code
    if (isAuthenticated) {
// Adicione o ID do usuário
    } else {
      updateState(UnauthenticatedUser());
    }
    
    Navigator.pushReplacementNamed(context, NamedRoutes.initial);
  }
}
