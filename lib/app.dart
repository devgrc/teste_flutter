import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'package:teste_flutter/features/categorias/categorias_page.dart';
import 'package:teste_flutter/features/chatbot/chat_bot_page.dart';
import 'package:teste_flutter/features/insights/graficos_page.dart';
import 'package:teste_flutter/features/onbording/onbording_page.dart';
import 'package:teste_flutter/features/perfil/perfil_page.dart';
import 'package:teste_flutter/features/sign_up/sign_up_page.dart';
import 'package:teste_flutter/features/splash/splash_page.dart';
import 'package:teste_flutter/features/transaction/add_transaction_page.dart';
import 'package:teste_flutter/features/transaction/all_transaction_page.dart';
import 'package:teste_flutter/utils/sizes.dart';
import 'package:intl/date_symbol_data_local.dart'; // Necessário para a formatação de data
import 'features/home/home_controller.dart';
import 'features/home/home_page.dart';
import 'features/login/login_page.dart';
import 'features/saldo/add_saldo_page.dart';
import 'features/categorias/categorias_state.dart'; // Importação do provider de categorias

// Adicionar as localizações globais necessárias
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // Inicializa a formatação de data com a localidade pt_BR
  await initializeDateFormatting('pt_BR', null);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializa a classe Sizes para gerenciamento de tamanhos
    Sizes.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()), // Fornecendo o CategoryProvider
      ],
      child: MaterialApp(
        locale: const Locale('pt', 'BR'), // Define a localidade para pt_BR globalmente
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('pt', 'BR'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          // Aqui você pode adicionar mais delegados se necessário
        ],
        initialRoute: NamedRoutes.home,
        routes: {
          NamedRoutes.signUp: (context) => const SignUpPage(),
          NamedRoutes.login: (context) => const LoginPage(),
          NamedRoutes.addSaldo: (context) => AddSaldoPage(homeController: context.read<HomeController>()),
          NamedRoutes.home: (context) => HomePage(),
          NamedRoutes.initial: (context) => const OnboardngPage(),
          NamedRoutes.splash: (context) => const SplashPage(),
          NamedRoutes.chat: (context) => const ChatBotPage(),
          NamedRoutes.transaction: (context) => AddTransactionPage(), // Rota para adicionar transação
          NamedRoutes.perfil: (context) => PerfilPage(),
          NamedRoutes.categorias: (context) => CategoriasPage(),
          NamedRoutes.graficos: (context) => GraficosPage(),
          NamedRoutes.allTransactions: (context) => AllTransactionPage(),
        },
      ),
    );
  }
}
