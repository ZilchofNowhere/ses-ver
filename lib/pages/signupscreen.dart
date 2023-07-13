import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';
import 'package:greenie/assets/globals.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String emailValMsg = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  bool validateEmail(String email) {
    if (isEmail(email)) {
      setState(() {
        emailValMsg = "Geçerli!";
      });
      return true;
    } else {
      setState(() {
        emailValMsg = "E-mail adresiniz geçersiz.";
      });
      return false;
    }
  }

  Future<void> signupUser(BuildContext context) async {
    const String signupUrl = "/signup";

    final response = await http.post(
      Uri.parse(signupUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, String>{
          "username": _nameController.text.trim().toLowerCase(),
          "email": _emailController.text.trim().toLowerCase(),
          "password": _pwdController.text,
        },
      ),
    );

    if (context.mounted) {
      if (response.statusCode == 200) {
        Navigator.of(context).pop(); // back to login screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Hesabınızı oluştururken bir hata ile karşılaştık. (Hata kodu ${response.statusCode})"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ses Ver",
          style: TextStyle(
            color: appColor,
            fontFamily: "Gabriela",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Yeni bir hesap oluşturun!",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text("E-mail adresiniz"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir e-mail adresi girin.";
                      } else if (!isEmail(value)) {
                        return "Lütfen geçerli bir e-mail adresi girin.";
                      }
                      return null;
                    },
                    onChanged: (v) => validateEmail(v),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    emailValMsg,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text("Kullanıcı adınız"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir kullanıcı adı girin.";
                      } else if (value.trim().contains(' ') ||
                          !isAlphanumeric(value)) {
                        return "Lütfen geçerli bir kullanıcı adı girin.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Kullanıcı adınızda sadece sayılar veya küçük harfler kullanın.",
                    textAlign: TextAlign.center,
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
                      } else if (value.contains(' ') ||
                          !isAlphanumeric(value)) {
                        return "Lütfen geçerli bir şifre girin.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Şifrenizde sadece sayılar veya harfler kullanın.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signupUser(context);
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
                          child: const Text("Hesabınızı oluşturun"),
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
