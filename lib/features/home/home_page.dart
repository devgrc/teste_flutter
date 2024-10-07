import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart';
import 'package:teste_flutter/common/extensions/size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get TextScaleFactor => MediaQuery.of(context).size.width < 360.0 ? 0.7 : 1.0;
  double get iconsize => MediaQuery.of(context).size.width < 360.0 ? 16.0 : 24.0;
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('')),
    const Center(child: Text('Insights Screen')),
    const Center(child: Text('ChatBot Screen')),
    const Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Seção de boas-vindas
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
                        SizedBox(width: 16.0),
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(20.h),
                  width: 370.w,
                  height: 111.h,
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
                      Text('Saldo', style: AppTextStyles.KanitSaldo.copyWith(fontSize: 20 * textScaleFactor)),
                      Text('R\$ 100,00', style: AppTextStyles.KodchasanValor.copyWith(fontSize: 16 * textScaleFactor)),
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Botão esquerdo pressionado!');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(70.w, 100.h),
                            backgroundColor: const Color(0xFFB8EFCB),
                            elevation: 7.0,
                            shadowColor: const Color(0xFF000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 40.0,
                                width: 52.0,
                                child: Icon(Icons.arrow_upward,
                                    color: Colors.black, size: 40.0),
                              ),
                              SizedBox(height: 4.0),
                              Text('Receitas',
                                  style: AppTextStyles.KantumruyDespRecei.copyWith(fontSize: 16 * textScaleFactor)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      const BotaoAdd(),
                      SizedBox(width: 20.w),
                      // Botão Despesas
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Botão direito pressionado!');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(70.w, 100.h),
                            backgroundColor: const Color(0xFFB8EFCB),
                            elevation: 7.0,
                            shadowColor: const Color(0xFF000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 40.0,
                                width: 40.0,
                                child: Icon(Icons.arrow_downward,
                                    color: Colors.black, size: 40.0),
                              ),
                              const SizedBox(height: 4.0),
                              Text('Despesas',
                                  style: AppTextStyles.KantumruyDespRecei.copyWith(fontSize: 16 * textScaleFactor)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 35.h),
            // Corpo da HomePage
            Center(
              child: _widgetOptions[_selectedIndex],
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
              color: _selectedIndex == 0
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => _onItemTapped(0),
              iconSize: 35.0,
            ),
            IconButton(
              icon: const Icon(Icons.insights),
              color: _selectedIndex == 1
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => _onItemTapped(1),
              iconSize: 35.0,
            ),
            const SizedBox(width: 48), // Espaço para o botão central flutuante
            IconButton(
              icon: const Icon(Icons.chat),
              color: _selectedIndex == 2
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => _onItemTapped(2),
              iconSize: 35.0,
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: _selectedIndex == 3
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : Colors.grey.withOpacity(0.5),
              onPressed: () => _onItemTapped(3),
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
  const BotaoAdd({
    super.key,
  });

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
