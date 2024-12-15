import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/features/home/home_controller.dart';
import 'dart:math';

class GraficosPage extends StatefulWidget {
  const GraficosPage({super.key, required HomeController homeController});

  @override
  _GraficosPageState createState() => _GraficosPageState();
}

class _GraficosPageState extends State<GraficosPage> {
  // Mapa para armazenar as cores geradas para as categorias
  Map<String, Color> categoriaCores = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualização de Dados'),
        titleTextStyle: AppTextStyles.KodchasanAddTandaction,
        backgroundColor: const Color(0xFF003617),
        centerTitle: true,
      ),
      backgroundColor: const Color(0x33B8EFCB), // Adiciona a cor de fundo
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, homeController, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSaldoTotalCard(homeController),
                    const SizedBox(height: 20),
                    _buildCategoriasPieChart(homeController),
                    const SizedBox(height: 20),
                    _buildReceitaDespesaBarChart(homeController),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSaldoTotalCard(HomeController homeController) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Saldo Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              homeController.formattedBalance,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: homeController.balance >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriasPieChart(HomeController homeController) {
    // Agrupa transações por categoria
    Map<String, double> categoriaValores = {};
    for (var transacao in homeController.historico) {
      if (transacao.tipo == 'Despesa') {
        categoriaValores[transacao.categoria] =
            (categoriaValores[transacao.categoria] ?? 0) + transacao.valor;
      }
    }

    // Converte para lista de PieData com a cor associada
    List<PieData> pieData = categoriaValores.entries.map((entry) {
      // Verifica se já existe uma cor para a categoria
      Color color = categoriaCores[entry.key] ?? _generateUniqueColor(entry.key);
      return PieData(entry.key, entry.value, color);
    }).toList();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Distribuição de Despesas por Categoria',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            pieData.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Sem dados de despesas'),
                  )
                : SfCircularChart(
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries>[
                      PieSeries<PieData, String>(
                        dataSource: pieData,
                        xValueMapper: (PieData data, _) => data.category,
                        yValueMapper: (PieData data, _) => data.value,
                        pointColorMapper: (PieData data, _) => data.color,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.inside,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // Função para gerar uma cor única para uma categoria
  Color _generateUniqueColor(String categoria) {
    // Gerar uma cor aleatória com base no nome da categoria
    final random = Random(categoria.hashCode);
    return Color.fromARGB(
      255,
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  Widget _buildReceitaDespesaBarChart(HomeController homeController) {
    // Agrupa transações por mês
    Map<String, double> receitasPorMes = {};
    Map<String, double> despesasPorMes = {};

    for (var transacao in homeController.historico) {
      String mesAno = DateFormat('MM/yyyy').format(transacao.data);

      if (transacao.tipo == 'Receita') {
        receitasPorMes[mesAno] = (receitasPorMes[mesAno] ?? 0) + transacao.valor;
      } else if (transacao.tipo == 'Despesa') {
        despesasPorMes[mesAno] = (despesasPorMes[mesAno] ?? 0) + transacao.valor;
      }
    }

    // Combina todas as chaves de meses
    Set<String> todosMeses = {...receitasPorMes.keys, ...despesasPorMes.keys};

    // Cria lista de dados para o gráfico
    List<FinancialData> chartData = todosMeses.map((mesAno) {
      return FinancialData(
        mesAno,
        receitasPorMes[mesAno] ?? 0,
        despesasPorMes[mesAno] ?? 0,
      );
    }).toList();

    // Ordena por data
    chartData.sort((a, b) {
      var dateA = DateFormat('MM/yyyy').parse(a.month);
      var dateB = DateFormat('MM/yyyy').parse(b.month);
      return dateA.compareTo(dateB);
    });

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Receitas vs Despesas por Mês',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            chartData.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Sem dados financeiros'),
                  )
                : SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelRotation: 45,
                      interval: 1,
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Valores (R\$)'),
                      numberFormat: NumberFormat.simpleCurrency(locale: 'pt_BR'),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<FinancialData, String>>[
                      ColumnSeries<FinancialData, String>(
                        dataSource: chartData,
                        xValueMapper: (FinancialData data, _) => data.month,
                        yValueMapper: (FinancialData data, _) => data.receitas,
                        name: 'Receitas',
                        color: Colors.green,
                      ),
                      ColumnSeries<FinancialData, String>(
                        dataSource: chartData,
                        xValueMapper: (FinancialData data, _) => data.month,
                        yValueMapper: (FinancialData data, _) => data.despesas,
                        name: 'Despesas',
                        color: Colors.red,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

// Classes de dados para os gráficos
class PieData {
  final String category;
  final double value;
  final Color color;

  PieData(this.category, this.value, this.color);
}

class FinancialData {
  final String month;
  final double receitas;
  final double despesas;

  FinancialData(this.month, this.receitas, this.despesas);
}
