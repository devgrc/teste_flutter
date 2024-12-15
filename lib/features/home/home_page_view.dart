import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'package:teste_flutter/features/chatbot/chat_bot_page.dart';
import 'package:teste_flutter/features/insights/graficos_page.dart';
import 'package:teste_flutter/features/perfil/perfil_page.dart';
import 'package:teste_flutter/features/transaction/all_transaction_page.dart';
import 'package:teste_flutter/utils/sizes.dart';
import 'home_controller.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {
  final HomeController controller;

  const HomePageView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          // Lista de páginas para navegação
          final List<Widget> pages = [
            _buildHomePage(context, textScaleFactor),
             GraficosPage(homeController: controller), // Página de Insights
            const ChatBotPage(), // Página do ChatBot
            const PerfilPage(),
          ];

          return pages[controller.state.selectedIndex.clamp(
              0, pages.length - 1)]; // Exibe a página de acordo com o índice
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color(0xFF003617),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: controller.state.selectedIndex == 0
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => controller.updateSelectedIndex(0),
              iconSize: 35.0,
            ),
            IconButton(
              icon: const Icon(Icons.insights),
              color: controller.state.selectedIndex == 1
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => controller.updateSelectedIndex(1),
              iconSize: 35.0,
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.chat),
              color: controller.state.selectedIndex == 2
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => controller.updateSelectedIndex(
                  2), // Quando clicar no chat, vai para a página do chatbot
              iconSize: 35.0,
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: controller.state.selectedIndex == 3
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => controller.updateSelectedIndex(3),
              iconSize: 35.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NamedRoutes.transaction);
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFB8EFCB),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Método para construir a página inicial (HomePage)
  Widget _buildHomePage(BuildContext context, double textScaleFactor) {
    return Container(
      color: const Color(0x00b8efcb).withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Container(
              padding: EdgeInsets.all(16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bem-vindo!',
                            style: TextStyle(
                              fontSize: 20.0 * textScaleFactor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Nome do Usuário',
                            style: TextStyle(fontSize: 16.0 * textScaleFactor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Lógica para abrir a tela de notificações
                    },
                    color: Colors.black,
                    iconSize: 30.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 35.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.h),
                    width: Sizes().width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xFF003617),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saldo',
                          style: AppTextStyles.KanitSaldo.copyWith(
                            fontSize: 20 * textScaleFactor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Consumer<HomeController>(
                          builder: (context, controller, child) {
                            return Text(
                              controller.formattedBalance,
                              style: AppTextStyles.KodchasanValor.copyWith(
                                fontSize: 16 * textScaleFactor,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        Consumer<HomeController>(
                          builder: (context, controller, child) {
                            return Container(
                              width: controller.progressBarWidth,
                              height: 8.61.h,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFB8EFCB).withOpacity(0.65),
                                borderRadius: BorderRadius.circular(4.3),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 88.0.h,
                          width: 100.0.w,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, NamedRoutes.categorias);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              elevation: 7.0,
                              shadowColor: const Color(0xFF000000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Navega para a página de Categorias usando a rota nomeada
                                Navigator.pushNamed(
                                    context, NamedRoutes.transaction);
                              },
                              child: GestureDetector(
                                onTap: () {
                                  // Navega para a página de Categorias usando a rota nomeada
                                  Navigator.pushNamed(
                                      context, NamedRoutes.categorias);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.category_rounded,
                                        color: Colors.black, size: 40.0),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Categorias',
                                      style: AppTextStyles.KantumruyDespRecei
                                          .copyWith(
                                              fontSize: 11 * textScaleFactor),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, NamedRoutes.transaction);
                            print('Botão Adicionar pressionado!');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(123, 125),
                            backgroundColor: const Color(0xFFB8EFCB),
                            elevation: 7.0,
                            shadowColor: const Color(0xFF000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            width: 75.0,
                            height: 68.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFF003617),
                              shape: BoxShape.circle,
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add_to_photos_rounded,
                                color: Colors.white,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        SizedBox(
                          height: 88.0.h,
                          width: 100.0.w,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, NamedRoutes.calendario);
                              print('Botão Lembretes pressionado!');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              elevation: 7.0,
                              shadowColor: const Color(0xFF000000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.calendar_month_rounded,
                                    color: Colors.black, size: 40.0),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Calendário',
                                  style:
                                      AppTextStyles.KantumruyDespRecei.copyWith(
                                          fontSize: 11 * textScaleFactor),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.h),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  29.0), // Padding horizontal para alinhar com o resto do conteúdo
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Histórico Recente',
                                style: AppTextStyles.HistoricoRecente,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navega para a página AllTransactionPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AllTransactionPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Ver Tudo',
                                  style: AppTextStyles.HistoricoRecente,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 0.0),
                        Consumer<HomeController>(
                            builder: (context, controller, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.transactions
                                .take(3)
                                .length, // Limita para 3 transações
                            itemBuilder: (context, index) {
                              final transaction = controller
                                  .transactions.reversed
                                  .toList()[index];
                              final formattedValue = NumberFormat.currency(
                                      locale: 'pt_BR', symbol: '')
                                  .format(transaction.valor);
                              final formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(transaction.data);

                              return Container(
                                width: 369.w,
                                height: 66.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 24.w),
                                padding: EdgeInsets.all(10.h),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 42.w,
                                          height: 40.h,
                                          padding: EdgeInsets
                                              .symmetric(), // Adicionando padding
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF003617)
                                                .withOpacity(0.25),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Icon(transaction.icon,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                size: 30.h),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(transaction.nome,
                                                style:
                                                    TextStyle(fontSize: 16.h)),
                                            Text(
                                              '${transaction.categoria} - ${transaction.tipo}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.h),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(formattedDate,
                                            style: TextStyle(
                                                fontSize: 12.h,
                                                color: Colors.grey)),
                                        Text(
                                          formattedValue,
                                          style: TextStyle(
                                            fontSize: 16.h,
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
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
