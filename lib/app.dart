import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'package:teste_flutter/features/categorias/categorias_page.dart';
import 'package:teste_flutter/features/chatbot/chat_bot_page.dart';
import 'package:teste_flutter/features/onbording/onbording_page.dart';
import 'package:teste_flutter/features/perfil/perfil_page.dart';
import 'package:teste_flutter/features/sign_up/sign_up_page.dart';
import 'package:teste_flutter/features/splash/splash_page.dart';
import 'package:teste_flutter/features/transaction/add_transaction_page.dart';
import 'features/home/home_controller.dart';
import 'features/home/home_page.dart';
import 'features/login/login_page.dart';
import 'features/saldo/add_saldo_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        initialRoute: NamedRoutes.home,
        routes: {
          NamedRoutes.signUp: (context) => const SignUpPage(),
          NamedRoutes.login: (context) => const LoginPage(),
          NamedRoutes.addSaldo: (context) => AddSaldoPage(homeController: context.read<HomeController>()),
          NamedRoutes.home: (context) => HomePage(),
          NamedRoutes.initial: (context) => const OnboardngPage(),
          NamedRoutes.splash: (context) => const SplashPage(),
          NamedRoutes.chat: (context) => const ChatBotPage(),
          NamedRoutes.transaction: (context) => AddTransactionPage(), // Adicionando a rota para adicionar transação
          NamedRoutes.chat: (context) => ChatBotPage(), // Adicionando a rota para adicionar transação
          NamedRoutes.perfil: (context) => PerfilPage(), // Adicionando a rota para adicionar transação
          NamedRoutes.categorias: (context) => CategoriasPage(), 
        },
      ),
    );
  }
}

void main() {
  runApp(const App());
}
