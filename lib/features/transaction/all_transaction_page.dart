import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class AllTransactionPage extends StatelessWidget {
  const AllTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as Transações'),
        titleTextStyle: AppTextStyles.KodchasanAddTandaction,
        backgroundColor: const Color(0xFF003617),
        iconTheme: const IconThemeData(
            color: Colors.white), // Mudando a cor da seta de voltar para branco
      ),
      body: Container(
        color: const Color(0x00b8efcb).withOpacity(0.3), // Cor de fundo com opacidade
        child: Consumer<HomeController>(
          builder: (context, controller, _) {
            return ListView.builder(
              itemCount: controller.transactions.length, // Exibe todas as transações
              itemBuilder: (context, index) {
                // Reverte a lista para exibir as transações mais recentes no topo
                final transaction = controller.transactions.reversed.toList()[index];

                final formattedValue = NumberFormat.currency(
                        locale: 'pt_BR', symbol: '')
                    .format(transaction.valor); // Formata o valor da transação
                final formattedDate = DateFormat('dd/MM/yyyy')
                    .format(transaction.data); // Formata a data da transação

                // Verifica se o item é o primeiro e aplica uma margem superior
                final marginTop = index == 0 ? 20.0 : 5.0; // Margem maior para o primeiro item

                return Container(
                  width: double.infinity,
                  height: 80.0,
                  margin: EdgeInsets.only(
                    top: marginTop, // Aplica a margem superior somente ao primeiro item
                    bottom: 5.0,  // Mantém a margem inferior padrão
                    left: 24.0,   // Margem à esquerda
                    right: 24.0,  // Margem à direita
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0), // Preenchimento para espaçar o conteúdo dentro do container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 40,
                            padding: EdgeInsets.symmetric(), // Adicionando padding igual em todas as direções
                            decoration: BoxDecoration(
                              color: const Color(0xFF003617).withOpacity(0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                transaction.icon,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                size: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0), // Espaçamento entre o ícone e o texto
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                transaction.nome,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                '${transaction.categoria} - ${transaction.tipo}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                          Text(
                            formattedValue,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: transaction.tipo == 'Receita'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
