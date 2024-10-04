import 'package:flutter/material.dart';
import 'package:teste_flutter/common/app_text_styles.dart'; // Certifique-se de ter esse arquivo criado com as devidas definições de estilos de texto.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      body: Column(
        children: [
          // Seção de boas-vindas
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bem-vindo!',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Text('Nome do Usuário',
                              style: TextStyle(fontSize: 16.0)),
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
          const SizedBox(height: 35.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                width: 370.0,
                height: 111.0,
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saldo', style: AppTextStyles.KanitSaldo),
                    Text('R\$ 100,00', style: AppTextStyles.KodchasanValor),
                  ],
                ),
              ),
              const SizedBox(
                  height:
                      20.0), // Espaçamento entre o container e a linha de botões
              Padding(
                padding: const EdgeInsets.only(left: 33.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Primeiro botão menor à esquerda do botaoAdd
                    ElevatedButton(
                      onPressed: () {
                        print('Botão esquerdo pressionado!');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(43.0, 100.0),
                        backgroundColor: const Color(0xFFB8EFCB),
                        elevation: 7.0,
                        shadowColor: const Color(0xFF000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_upward,
                              color: Colors.black, size: 40.0),
                          SizedBox(height: 4.0),
                          Text('Receitas',
                              style: AppTextStyles.KantumruyDespRecei),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14.0), // Espaçamento entre os botões
                    // Botão principal (botaoAdd)
                    const botaoAdd(),
                    const SizedBox(width: 14.0),
                    // Segundo botão menor à direita do botaoAdd
                    ElevatedButton(
                      onPressed: () {
                        print('Botão direito pressionado!');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(43.0, 100.0),
                        backgroundColor: const Color(0xFFB8EFCB),
                        elevation: 7.0,
                        shadowColor: const Color(0xFF000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_downward,
                              color: Colors.black, size: 40.0),
                          SizedBox(height: 4.0),
                          Text('Despesas',
                              style: AppTextStyles.KantumruyDespRecei),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 35.0),
          // Corpo da HomePage
          Expanded(
            child: Center(
              child: _widgetOptions[_selectedIndex],
            ),
          ),
        ],
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

class botaoAdd extends StatelessWidget {
  const botaoAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('Botão pressionado!');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(123.0, 125.0),
        backgroundColor: const Color(0xFFB8EFCB), // Cor de fundo
        elevation: 7.0,
        shadowColor: const Color(0xFF000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Cantos arredondados
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 75.0,
        height: 68.0,
        decoration: const BoxDecoration(
          color: Color(0xFF003617), // Cor do quadrado interno
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.add_to_photos_rounded, // Ícone de mais
            color: Colors.white,
            size: 40.0,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
