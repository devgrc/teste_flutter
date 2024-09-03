import 'package:flutter/material.dart';
import 'package:teste_flutter/features/login/login_page.dart';
import 'package:teste_flutter/features/sign_up/sign_up_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpPage(),
    );
  }
}