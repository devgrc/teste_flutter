import 'dart:async';
import 'dart:ui';
import 'package:teste_flutter/features/home/home_controller.dart';
import 'add_saldo_state.dart';

class AddSaldoController {
  final _stateController = StreamController<AddSaldoState>();
  final HomeController homeController;

  Stream<AddSaldoState> get state => _stateController.stream;

  AddSaldoController(this.homeController);

  void submitForm(String amount, VoidCallback onSuccess) {
    _stateController.add(AddSaldoStateLoading());

    // Simulação de uma chamada de API
    Future.delayed(const Duration(seconds: 2), () {
      try {
        // Lógica de adição de saldo
        double parsedAmount = double.parse(amount);
        if (parsedAmount >= 0) {
          homeController.addToBalance(parsedAmount); // Atualiza o saldo
          _stateController.add(AddSaldoStateSuccess());
          onSuccess();
        } else {
          _stateController.add(AddSaldoStateError('Valor deve ser maior que zero'));
        }
      } catch (e) {
        _stateController.add(AddSaldoStateError('Erro ao adicionar saldo: ${e.toString()}'));
      }
    });
  }

  void dispose() {
    _stateController.close();
  }
}
