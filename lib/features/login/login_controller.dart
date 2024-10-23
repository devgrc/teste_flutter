import 'dart:async';
import 'dart:ui';
import 'login_state.dart';

class LoginController {
  final _stateController = StreamController<SignInState>();

  Stream<SignInState> get state => _stateController.stream;

  void submitForm(String email, String password, VoidCallback onSuccess) {
    _stateController.add(SignInStateLoading());

    // Simulação de uma chamada de API
    Future.delayed(const Duration(seconds: 2), () {
      try {
        // Lógica de autenticação
        if (email.isNotEmpty && password.isNotEmpty) {
          _stateController.add(SignInStateSuccess());
          onSuccess();
        } else {
          _stateController.add(SignInStateError('Credenciais inválidas'));
        }
      } catch (e) {
        _stateController.add(SignInStateError('Erro ao fazer login'));
      }
    });
  }

  void dispose() {
    _stateController.close();
  }
}
