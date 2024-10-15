import 'dart:async';
import 'login_state.dart';

class LoginController {
  final StreamController<SignInState> _stateController = StreamController<SignInState>();

  Stream<SignInState> get state => _stateController.stream;

  void dispose() {
    _stateController.close();
  }

  void submitForm(String email, String password, Function onSuccess) {
    _stateController.add(SignInStateLoading());

    // Simulação de uma requisição de login
    Future.delayed(const Duration(seconds: 1), () {
      if (email.isNotEmpty && password.length >= 6) {
        _stateController.add(SignInStateSuccess());
        onSuccess(); // Chama a função de sucesso
      } else {
        _stateController.add(SignInStateError("Credenciais inválidas."));
      }
    });
  }
}
