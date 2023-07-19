import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenie/pages/signupscreen.dart';
import 'package:http/http.dart' as http;
import 'package:greenie/assets/user.dart';
import 'package:greenie/pages/homepage.dart';
import 'package:greenie/assets/globals.dart';

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

  Future<void> initRememberMe() async {
    bool r = await storage.read(key: "rememberMe") == "true";
    setState(
      () {
        rememberMe = r;
      },
    );
  }

  Future<void> loginUser(BuildContext context) async {
    const String loginUrl = "/login";

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, String>{
          "username": _nameController.text.trim(),
          "password": _pwdController.text
        },
      ),
    );

    if (context.mounted) {
      if (response.statusCode == 200) {
        var decodedData = decryptJWT(response.body);
        if (rememberMe) {
          storage.write(
            key: "savedUserName",
            value: decodedData["username"] as String,
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
          name: decodedData["username"] as String,
          profilePicPath: decodedData["pfp"] as String,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomePage(
              user: curUser,
            ),
          ),
        );
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
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
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child:
                              const Text("Hesabınız yok mu? Hesap oluşturun!"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red),
                          ),
                          onPressed: () {},
                          child: const Text("Şifremi unuttum"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.yellow),
                          ),
                          onPressed: () {
                            for (var _ in [1, 2, 3, 4, 5]) {
                              exUser.addPost(exPost);
                            }
                            curUser = exUser;
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => HomePage(user: curUser),
                              ),
                            );
                          },
                          child: const Text("Debug"),
                        ),
                      ),
                    ],
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
