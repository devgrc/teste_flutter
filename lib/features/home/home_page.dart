import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page_view.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageView(controller: controller);
  }
}
