import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceitaDespesa {
  final String nome;
  final double valor;
  final String tipo; // 'Receita' ou 'Despesa'
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
  double _balance = 0.0;
  List<ReceitaDespesa> _historico = []; // Histórico de receitas e despesas
  final HomeState _state = HomeState();

  double get balance => _balance;
  HomeState get state => _state;

  // Formata o saldo no formato "0,00"
  String get formattedBalance =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$ ', decimalDigits: 2)
          .format(_balance);

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
    // Atualiza o saldo
    if (item.tipo == 'Receita') {
      _balance += item.valor;
    } else if (item.tipo == 'Despesa') {
      _balance -= item.valor;
    }
    notifyListeners();
  }

  List<ReceitaDespesa> get historico => _historico;

  // Para calcular a largura da barra de progresso, se necessário
  double get progressBarWidth => _balance > 0 ? 350 : 0;

  // Método para obter transações formatadas para exibição
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

  // Método para obter transações (getter)
  List<ReceitaDespesa> get transactions =>
      _historico; // Retorna o histórico de receitas e despesas
}
