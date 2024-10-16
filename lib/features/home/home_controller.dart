import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home_state.dart';

class HomeController extends ChangeNotifier {
  HomeState _state;

  HomeController() : _state = HomeState();

  HomeState get state => _state;

  void updateSelectedIndex(int index) {
    _state.selectedIndex = index;
    notifyListeners();
  }

  double get progressBarWidth {
    return (_state.currentBalance / _state.maxBalance) * 326; // 326 é a largura total da barra
  }

  String get formattedBalance {
    return NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      decimalDigits: 2,
    ).format(_state.currentBalance);
  }
}
