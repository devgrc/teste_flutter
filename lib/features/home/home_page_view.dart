import 'package:flutter/material.dart';
import 'home_controller.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/common/extensions/sizes.dart';

class HomePageView extends StatelessWidget {
  final HomeController controller;

  const HomePageView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      extendBody: true,
      body: Container(
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
                      width: Sizes().width * 0.9, // Ajuste para 90% da largura
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
                          Text(
                            controller.formattedBalance,
                            style: AppTextStyles.KodchasanValor.copyWith(
                              fontSize: 16 * textScaleFactor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: controller.progressBarWidth,
                            height: 8.61.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB8EFCB).withOpacity(0.65),
                              borderRadius: BorderRadius.circular(4.3),
                            ),
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
                          // Botão Receitas
                          SizedBox(
                            height: 88.0.h,
                            width: 100.0.w,
                            child: ElevatedButton(
                              onPressed: () {
                                print('Botão Calendário pressionado!');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                elevation: 7.0,
                                shadowColor: const Color(0xFF000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month_rounded, color: Colors.black, size: 40.0),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Calendário',
                                    style: AppTextStyles.KantumruyDespRecei.copyWith(fontSize: 11 * textScaleFactor),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          const BotaoAdd(),
                          SizedBox(width: 20.w),
                          // Botão Despesas
                          SizedBox(
                            height: 88.0.h,
                            width: 100.0.w,
                            child: ElevatedButton(
                              onPressed: () {
                                print('Botão Lembretes pressionado!');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                elevation: 7.0,
                                shadowColor: const Color(0xFF000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.receipt_long_rounded, color: Colors.black, size: 40.0),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Lembretes',
                                    style: AppTextStyles.KantumruyDespRecei.copyWith(fontSize: 11 * textScaleFactor),
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
                    SizedBox(height: 25.h),
                    Container(
                      padding: const EdgeInsets.all(23.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Histórico Recente',
                                style: AppTextStyles.HistoricoRecente,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Lógica para ver tudo
                                },
                                child: const Text(
                                  'Ver Tudo',
                                  style: AppTextStyles.HistoricoRecente,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 200.0.h,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                final color = index % 2 == 0 ? Colors.green : Colors.red;
                                final value = index % 2 == 0 ? '+ R\$ 100,00' : '- R\$ 50,00';
                                const date = '01/01/2023';

                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  leading: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Icon(Icons.monetization_on_rounded),
                                  ),
                                  title: const Text('Transferência', style: AppTextStyles.TituloDesRec),
                                  subtitle: const Text('Fundos de Emergência', style: AppTextStyles.SubCategoria),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(date, style: AppTextStyles.Date),
                                      Text(value, style: AppTextStyles.Valor.apply(color: color)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              onPressed: () => controller.updateSelectedIndex(2),
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
          // Lógica para adicionar capital
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFB8EFCB),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BotaoAdd extends StatelessWidget {
  const BotaoAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('Botão pressionado!');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(123.w, 125.h),
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
    );
  }
}
