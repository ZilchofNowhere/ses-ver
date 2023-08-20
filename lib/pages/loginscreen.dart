import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenie/pages/signupscreen.dart';
import 'package:greenie/widgets/widebutton.dart';
import 'package:http/http.dart' as http;
import 'package:greenie/assets/user.dart';
import 'package:greenie/pages/homepage.dart';
import 'package:greenie/assets/globals.dart';
import 'package:location/location.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool rememberMe = false;

  Future<bool> enableLocationService() async {
    bool servEnabled;
    PermissionStatus granted;

    servEnabled = await location.serviceEnabled();
    if (!servEnabled) {
      servEnabled = await location.requestService();
      if (!servEnabled) {
        return false;
      }
    }

    granted = await location.hasPermission();
    if (granted == PermissionStatus.denied) {
      granted = await location.requestPermission();
      if (granted == PermissionStatus.denied) {
        return false;
      }
    }

    return true;
  }

  Future<void> initRememberMe() async {
    bool r = await storage.read(key: "rememberMe") == "true";
    setState(
      () {
        rememberMe = r;
      },
    );
  }

  Future<void> loginUser(BuildContext context) async {
    const String loginUrl = "$testIp/login";

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, String>{
          "name": _nameController.text.trim(),
          "password": _pwdController.text
        },
      ),
    );

    if (context.mounted) {
      if (response.statusCode == 201) {
        var decodedData = jsonDecode(response.body)["user"];
        final token = jsonDecode(response.body)["token"] as String;
        if (rememberMe) {
          storage.write(
            key: "savedUserName",
            value: decodedData["name"] as String,
          );
          storage.write(
            key: "savedEmail",
            value: decodedData["email"] as String,
          );
          storage.write(
            key: "savedPFP",
            value: decodedData["pfp"] as String,
          );
        }
        // navigation to home
        curUser = User(
          email: decodedData["email"] as String,
          name: decodedData["name"] as String,
          profilePicPath: decodedData["pfp"] ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/340px-Default_pfp.svg.png",
          token: token,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomePage(
              user: curUser,
            ),
          ),
        );
        locationGranted = await enableLocationService();
      } else {
        // login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Giriş yapılırken bir hata ile karşılaştık. (Hata kodu ${response.statusCode})",
            ),
          ),
        );
      }
    }
  }

  Future<void> exLogin() async {
    for (var _ in [1, 2, 3, 4, 5]) {
      exUser.addPost(exPost);
    }
    curUser = exUser;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomePage(user: curUser),
      ),
    );

    locationGranted = await enableLocationService();
  }

  @override
  Widget build(BuildContext context) {
    initRememberMe();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ses Ver",
          style: TextStyle(
            fontFamily: "Gabriela",
            color: appColor,
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hoş geldiniz!",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text("Kullanıcı adınız"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir kullanıcı adı girin.";
                      } else if (value.trim().contains(' ')) {
                        return "Lütfen geçerli bir kullanıcı adı girin.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _pwdController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text("Şifreniz"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir şifre girin.";
                      } else if (value.contains(' ')) {
                        return "Lütfen geçerli bir şifre girin.";
                      }
                      return null;
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "Beni hatırla",
                      style: TextStyle(),
                    ),
                    contentPadding: const EdgeInsets.all(2),
                    value: rememberMe,
                    onChanged: (bool? val) {
                      setState(() {
                        rememberMe = val!;
                      });
                      storage.write(
                        key: "rememberMe",
                        value: rememberMe.toString(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  WideButton(
                    elevated: true,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginUser(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Lütfen yukarıdaki alanları eksiksiz doldurun.",
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text("Giriş yapın"),
                  ),
                  WideButton(
                    elevated: false,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text("Hesabınız yok mu? Hesap oluşturun!"),
                  ),
                  WideButton(
                    elevated: false,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                    ),
                    onPressed: () {},
                    child: const Text("Şifremi unuttum"),
                  ),
                  WideButton(
                    elevated: false,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.yellow),
                    ),
                    onPressed: () => exLogin(),
                    child: const Text("Debug"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
