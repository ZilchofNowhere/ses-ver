import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenie/assets/post.dart';
import 'package:greenie/assets/user.dart';

// example structures
User exUser = User(
  name: "ekocan",
  email: "example@example.com",
  profilePicPath: "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
);

Post exPost = Post(
  id: Random.secure().nextInt(100),
  author: exUser,
  content:
      "Ben doğada çok eğleniyorum, siz de orada zaman geçirmek istemez misiniz?",
  image: "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
);

//TODO: bring the events class here
const items = [
  [
    "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
    "Fatih'teki çiçek bahçelerini temizliyoruz",
  ],
  [
    "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
    "Mobil bir uygulama geliştiriyoruz",
  ],
  [
    "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
    "Patreon üzerinden çalışmamıza destek verin",
  ]
];
// tools
Map<String, dynamic> decryptJWT(String jwt) {
  return jsonDecode(
    ascii.decode(
      base64.decode(
        base64.normalize(
          jwt.split('.')[1],
        ),
      ),
    ),
  );
}

// globals
const appTitle = "Ses Ver";
const appColor = Color.fromRGBO(12, 170, 8, 1);
User curUser = exUser;
const storage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);
