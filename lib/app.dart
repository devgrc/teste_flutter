import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'package:teste_flutter/features/onbording/onbording_page.dart';
import 'package:teste_flutter/features/sign_up/sign_up_page.dart';
import 'features/home/home_controller.dart';
import 'features/home/home_page.dart';
import 'features/login/login_page.dart';
import 'features/saldo/add_saldo_page.dart';
import 'features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: MaterialApp(
        initialRoute: NamedRoutes.addSaldo,
        routes: {
          NamedRoutes.signUp: (context) => const SignUpPage(),
          NamedRoutes.login: (context) => const LoginPage(),
          NamedRoutes.addSaldo: (context) => AddSaldoPage(homeController: context.read<HomeController>()),
          NamedRoutes.home: (context) => HomePage(),
          NamedRoutes.initial: (context) => const OnboardngPage(),
          NamedRoutes.splash: (context) => const SplashPage(),
        },
      ),
    );
  }
}

void main() {
  runApp(const App());
}
