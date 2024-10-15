import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/routes.dart';
import 'package:teste_flutter/features/home/home_page.dart';
import 'package:teste_flutter/features/login/login_page.dart';
import 'package:teste_flutter/features/onbording/onbording_page.dart';
import 'package:teste_flutter/features/sign_up/sign_up_page.dart';
import 'package:teste_flutter/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NamedRoutes.signUp,
      routes: {
        NamedRoutes.initial: (context) => const OnboardngPage(),
        NamedRoutes.splash: (context) => const SplashPage(),
        NamedRoutes.signUp: (context) => const SignUpPage(),
        NamedRoutes.login: (context) => const LoginPage(),
        NamedRoutes.home: (context) => const HomePage(),
      },
    );
  }
}
