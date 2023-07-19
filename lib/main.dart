import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/user.dart';
import 'package:greenie/pages/homepage.dart';
import 'package:greenie/pages/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List<dynamic>> isRememberMe() async {
    List<dynamic> res = [false, null];
    res[0] = await storage.read(key: "rememberMe") == "true" &&
        await storage.containsKey(key: "savedUserName");
    if (!res[0]) {
      res.add(null);
      return res;
    }

    String username = await storage.read(key: "savedUserName") as String;
    String email = await storage.read(key: "savedEmail") as String;
    String pfp = await storage.read(key: "savedPFP") as String;

    res.add(
      User(
        name: username,
        email: email,
        profilePicPath: pfp,
      ),
    );
    return res;
  }

  Widget homeScreen(List<dynamic> useri) {
    if (useri[0]) {
      curUser = useri[1];
      return HomePage(user: curUser);
    } else {
      return const LoginScreen();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<dynamic> userInfo = [false, null];
    isRememberMe().then((value) => userInfo = value);

    return MaterialApp(
      title: 'Ses Ver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: appColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: homeScreen(userInfo),
      debugShowCheckedModeBanner: false,
    );
  }
}
