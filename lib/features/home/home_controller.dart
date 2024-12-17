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
  double _progressBarWidth = 0.0; // Largura da barra de progresso inicializada em zero
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
    _addInitialBalanceToHistorico(initialBalance); // Adiciona o saldo inicial ao histórico
    _updateProgressBarWidth(); // Atualiza a barra de progresso com base no saldo inicial
    notifyListeners(); // Notifica os listeners para atualizar a UI
  }

  void updateBalance(double newBalance) {
    _balance = newBalance;
    _updateProgressBarWidth();
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
    } else if (item.tipo == 'Despesa') {
      _balance -= item.valor; // Subtrai a despesa do saldo
    }

    _updateProgressBarWidth();
    notifyListeners();
  }

  void updateReceitaDespesa(ReceitaDespesa item, bool isPago) {
    if (item.tipo == 'Receita' && isPago) {
      _balance += item.valor; // Incrementa o saldo com a receita
    } else if (item.tipo == 'Despesa' && isPago) {
      _balance -= item.valor; // Subtrai a despesa do saldo
    } else if (item.tipo == 'Receita' && !isPago) {
      _balance -= item.valor; // Subtrai a receita do saldo
    } else if (item.tipo == 'Despesa' && !isPago) {
      _balance += item.valor; // Incrementa o saldo com a despesa
    }

    _updateProgressBarWidth();
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

  // Método para atualizar o saldo e incluir vencimentos pagos no histórico de transações
  void updateBalanceAndHistoricoForVencimento(Map<String, dynamic> vencimento, bool isPago) {
    bool isDespesa = vencimento['tipo'] == 'Despesa';
    double valor = vencimento['valor'];
  
    if (isPago) {
      if (isDespesa) {
        _balance -= valor; // Subtrai a despesa do saldo
      } else {
        _balance += valor; // Incrementa o saldo com a receita
      }
  
      // Adiciona o vencimento ao histórico de transações
      ReceitaDespesa receitaDespesa = ReceitaDespesa(
        nome: vencimento['descricao'] ?? '', // Adiciona um valor padrão se for nulo
        valor: valor,
        tipo: vencimento['tipo'] ?? '', // Adiciona um valor padrão se for nulo
        categoria: vencimento['categoria'] ?? '', // Adiciona um valor padrão se for nulo
        data: vencimento['data'] != null ? DateTime.parse(vencimento['data']) : DateTime.now(),
        isCredit: !isDespesa,
        icon: isDespesa ? Icons.arrow_downward : Icons.arrow_upward,
      );
      _historico.add(receitaDespesa);
    } else {
      if (isDespesa) {
        _balance += valor; // Incrementa o saldo com a despesa
      } else {
        _balance -= valor; // Subtrai a receita do saldo
      }
  
      // Remove o vencimento do histórico de transações
      _historico.removeWhere((item) =>
          item.nome == (vencimento['descricao'] ?? '') &&
          item.valor == valor &&
          item.tipo == (vencimento['tipo'] ?? '') &&
          item.categoria == (vencimento['categoria'] ?? '') &&
          item.data == (vencimento['data'] != null ? DateTime.parse(vencimento['data']) : DateTime.now()));
    }
  
    _updateProgressBarWidth();
    notifyListeners();
  }

  // Método para adicionar o saldo inicial ao histórico
  void _addInitialBalanceToHistorico(double initialBalance) {
    ReceitaDespesa initialBalanceTransaction = ReceitaDespesa(
      nome: 'Saldo Inicial',
      valor: initialBalance,
      tipo: 'Receita',
      categoria: 'Saldo Inicial',
      data: DateTime.now(),
      isCredit: true,
      icon: Icons.attach_money,
    );
    _historico.add(initialBalanceTransaction);
  }

  // Método para atualizar a largura da barra de progresso com base no saldo atualizado
  void _updateProgressBarWidth() {
    if (_initialBalance == 0) {
      _progressBarWidth = _balance > 0 ? 350 : 0;
    } else {
      double proportion = _balance / _initialBalance;
      if (proportion <= 0) {
        _progressBarWidth = 0;
      } else if (proportion > 1) {
        _progressBarWidth = 350;
      } else {
        _progressBarWidth = 350 * proportion;
      }
    }
    print('ProgressBarWidth atualizado: $_progressBarWidth');
    notifyListeners();
  }
}
