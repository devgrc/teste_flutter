import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa o pacote intl

class HomeState {
  int selectedIndex = 0;
}

class HomeController extends ChangeNotifier {
  double _balance = 0.0;
  double _maxBalance = 0.0; // Saldo máximo é definido pelo valor que o usuário adiciona
  final HomeState _state = HomeState();

  double get balance => _balance;
  double get maxBalance => _maxBalance; // Para referência, se necessário
  HomeState get state => _state;

  // A barra de progresso está sempre cheia se o saldo do usuário for maior que 0
  double get progressBarWidth => _maxBalance > 0 ? 350 : 0; 

  // Formata o saldo no formato "0,00"
  String get formattedBalance => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$ ', decimalDigits: 2).format(_balance);

  void updateBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }

  void updateSelectedIndex(int index) {
    _state.selectedIndex = index;
    notifyListeners();
  }

  void addToBalance(double amount) {
    _balance += amount; // Adiciona ao saldo
    _maxBalance = amount; // Define o saldo máximo igual ao valor que o usuário adicionou
    notifyListeners();
  }

  void updateIndex(int i) {
    // Lógica de atualização do índice, se necessário
  }
}
