import 'package:flutter/material.dart';
import 'package:cabbage/components/my_app_bar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const MyAppBar(title: "设置"), body: Center());
  }
}
