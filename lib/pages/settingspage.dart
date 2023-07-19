import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: TextStyle(
            color: appColor,
            fontFamily: "Gabriela",
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
