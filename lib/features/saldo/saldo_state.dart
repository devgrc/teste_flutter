import 'package:teste_flutter/features/saldo/saldo.dart';

abstract class SaldoState {}

class SaldoStateLoading extends SaldoState {}

class SaldoStateLoaded extends SaldoState {
  final Saldo saldo;

  SaldoStateLoaded(this.saldo);
}

class SaldoStateError extends SaldoState {
  final String message;

  SaldoStateError(this.message);
}
