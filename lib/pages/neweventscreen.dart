import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/widgets/popupmenu.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
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
        actions: const [
          AppBarPopupMenu(),
        ],
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Container(),
    );
  }
}
