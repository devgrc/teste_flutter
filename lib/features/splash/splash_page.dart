import 'package:flutter/material.dart';
import 'package:teste_flutter/common/constants/app_colors.dart';
import 'splash_controller.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(context, _updateState);
    _controller.init();
  }

  void _updateState(SplashState state) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primalWhite,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x00b8efcb).withOpacity(0.3),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 252,
              height: 237,
            ),
          ),
          // Você pode exibir o estado atual aqui, se necessário
        ],
      ),
    );
  }
}
