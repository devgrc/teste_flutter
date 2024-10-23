abstract class AddSaldoState {}

class AddSaldoStateLoading extends AddSaldoState {}

class AddSaldoStateSuccess extends AddSaldoState {}

class AddSaldoStateError extends AddSaldoState {
  final String message;

  AddSaldoStateError(this.message);
}
