import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Home Screen')),
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
            padding: const EdgeInsets.only(top: 40.0), // Espaço na parte superior
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinha os itens nas extremidades
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0, // Tamanho do ícone do usuário
                        backgroundImage: AssetImage('assets/images/avatar.png'), // Adicione sua imagem
                      ),
                      SizedBox(width: 16.0), // Espaço entre o ícone e o texto
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bem-vindo!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Text('Nome do Usuário', style: TextStyle(fontSize: 16.0)),
                        ],
                      ),
                    ],
                  ),
                  // Ícone de notificação
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Lógica para abrir a tela de notificações
                    },
                    color: Colors.black, // Cor do ícone
                    iconSize: 30.0,
                  ),
                ],
              ),
            ),
          ),
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

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
