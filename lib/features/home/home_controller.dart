import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceitaDespesa {
  final String nome;
  final double valor;
  final String tipo;
  final String categoria;
  final DateTime data;
  final bool isCredit;
  final IconData icon;

  ReceitaDespesa({
    required this.nome,
    required this.valor,
    required this.tipo,
    required this.categoria,
    required this.data,
    required this.isCredit,
    required this.icon,
  });
}

class HomeState {
  int selectedIndex = 0;
}

class HomeController extends ChangeNotifier {
  double _balance = 0.0;  // Saldo atual
  double _initialBalance = 0.0; // Saldo inicial
  double _progressBarWidth = 350; // Largura da barra de progresso
  List<ReceitaDespesa> _historico = [];
  final HomeState _state = HomeState();

  double get balance => _balance;
  double get initialBalance => _initialBalance;
  HomeState get state => _state;
  double get progressBarWidth => _progressBarWidth;

  String get formattedBalance =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$ ', decimalDigits: 2)
          .format(_balance);

  // Método para definir o saldo inicial
  void setInitialBalance(double initialBalance) {
    _initialBalance = initialBalance; // Salva o saldo inicial
    _balance = initialBalance; // O saldo atual é igual ao saldo inicial
    _progressBarWidth = 350; // A barra de progresso começa cheia
    notifyListeners(); // Notifica os listeners para atualizar a UI
  }

  void updateBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }

  void updateSelectedIndex(int index) {
    _state.selectedIndex = index;
    notifyListeners();
  }

  void addReceitaDespesa(ReceitaDespesa item) {
    _historico.add(item);

    if (item.tipo == 'Receita') {
      _balance += item.valor; // Incrementa o saldo com a receita

      // Calcular a proporção do saldo em relação ao saldo inicial
      double proportion = _balance / _initialBalance;

      // Ajusta a largura da barra de progresso
      _progressBarWidth = (proportion > 1) ? 350 : 350 * proportion;
    } else if (item.tipo == 'Despesa') {
      _balance -= item.valor; // Subtrai a despesa do saldo

      // Ajuste da barra de progresso com base no saldo restante
      double proportion = (_balance < 0) ? 0 : (_balance / (_balance + item.valor)).abs();
      _progressBarWidth = 350 * proportion;
    }

    notifyListeners();
  }

  List<ReceitaDespesa> get historico => _historico;

  List<Map<String, String>> get transacoesFormatadas {
    return _historico.map((item) {
      final valorFormatado =
          NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2)
              .format(item.valor);
      final dataFormatada = DateFormat('dd/MM/yyyy').format(item.data);
      return {
        'nome': item.nome,
        'valor': '${item.tipo == 'Receita' ? '+' : '-'} R\$ $valorFormatado',
        'data': dataFormatada,
        'categoria': item.categoria,
      };
    }).toList();
  }

  List<ReceitaDespesa> get transactions => _historico;
}

