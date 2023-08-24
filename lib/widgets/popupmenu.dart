import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/user.dart';
import 'package:greenie/pages/loginscreen.dart';
import 'package:greenie/pages/settingspage.dart';
import 'package:http/http.dart' as http;

class AppBarPopupMenu extends StatefulWidget {
  const AppBarPopupMenu({super.key});

  @override
  State<AppBarPopupMenu> createState() => _AppBarPopupMenuState();
}

class _AppBarPopupMenuState extends State<AppBarPopupMenu> {
  Future<void> logoutUser() async {
    const apiUrl = "/logout";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (context.mounted) {
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        storage.write(
          key: "rememberMe",
          value: "false",
        );
      }
    }
  }

  void handlePopupClick(String choice) {
    switch (choice) {
      case "Çıkış yapın":
        logoutUser();
        break;
      case "Ayarlar":
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const SettingsPage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: handlePopupClick,
      itemBuilder: (context) {
        return {"Çıkış yapın", "Ayarlar"}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}

class UserPagePopupMenu extends StatefulWidget {
  final User user;
  const UserPagePopupMenu(this.user, {super.key});

  @override
  State<UserPagePopupMenu> createState() => _UserPagePopupMenuState();
}

class _UserPagePopupMenuState extends State<UserPagePopupMenu> {
  Future<void> logoutUser() async {
    const apiUrl = "/logout";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    if (context.mounted) {
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        storage.write(
          key: "rememberMe",
          value: "false",
        );
      }
    }
  }

  void handlePopupClick(String choice) {
    switch (choice) {
      case "Çıkış yapın":
        logoutUser();
        break;
      case "Ayarlar":
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const SettingsPage(),
          ),
        );
        break;
      case "Bildir":
        widget.user.reportUser();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: handlePopupClick,
      itemBuilder: (context) {
        return {"Bildir", "Çıkış yapın", "Ayarlar"}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
