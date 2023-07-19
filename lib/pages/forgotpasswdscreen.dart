// complete later
import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';

class ForgotPasswdScreen extends StatefulWidget {
  const ForgotPasswdScreen({super.key});

  @override
  State<ForgotPasswdScreen> createState() => _ForgotPasswdScreenState();
}

class _ForgotPasswdScreenState extends State<ForgotPasswdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: TextStyle(
            fontFamily: "Gabriela",
            color: appColor,
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
