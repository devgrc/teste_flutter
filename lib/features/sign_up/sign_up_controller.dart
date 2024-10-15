// lib/features/signup/sign_up_controller.dart

import 'package:flutter/material.dart';
import 'sign_up_state.dart';

class SignUpController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignUpState state = SignUpStateInitial();

  void submitForm(Function onSuccess) {
    if (formKey.currentState!.validate()) {
      state = SignUpStateLoading();
      
      // Simula uma requisição de cadastro
      Future.delayed(const Duration(seconds: 1), () {
        state = SignUpStateSuccess();
        onSuccess(); // Chama a função de sucesso passada
      });
    }
  }
}
