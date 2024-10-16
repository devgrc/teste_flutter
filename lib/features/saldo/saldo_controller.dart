import 'dart:async';
import 'saldo_state.dart';
import 'saldo.dart';

class SaldoController {
  final _stateController = StreamController<SaldoState>();
  Stream<SaldoState> get state => _stateController.stream;

  SaldoController() {
    _stateController.add(SaldoStateLoading());
    fetchSaldo(); // Busca o saldo ao inicializar
  }

  void dispose() {
    _stateController.close();
  }

  Future<void> fetchSaldo() async {
    // Simulando uma chamada assíncrona para buscar o saldo
    await Future.delayed(const Duration(seconds: 1));
    final saldo = Saldo(valor: 0.00); // Saldo inicial
    _stateController.add(SaldoStateLoaded(saldo));
  }

  void addSaldo(double amount) {
    // Simulando a adição de saldo
    final currentState = _stateController.value;
    if (currentState is SaldoStateLoaded) {
      final newSaldo = Saldo(valor: currentState.saldo.valor + amount);
      _stateController.add(SaldoStateLoaded(newSaldo));
    } else {
      _stateController.add(SaldoStateError('Erro ao adicionar saldo'));
    }
  }
}

extension on StreamController<SaldoState> {
   get value => null;
}
