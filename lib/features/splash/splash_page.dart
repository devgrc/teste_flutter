import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key, required AppBar appBar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF3EFEF),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}