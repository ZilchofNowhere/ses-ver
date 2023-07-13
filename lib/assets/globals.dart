import 'package:flutter/material.dart';
import 'package:greenie/assets/user.dart';

// example structures
User exUser = User(
  name: "ekocan",
  email: "example@example.com",
  profilePicPath: "assets/images/pfp.png",
);

List<User> users = [exUser];

//TODO: bring the events class here
const items = [
  [
    "assets/images/toprow.png",
    "Fatih'teki çiçek bahçelerini temizliyoruz",
  ],
  [
    "assets/images/toprow.png",
    "Mobil bir uygulama geliştiriyoruz",
  ],
  [
    "assets/images/toprow.png",
    "Patreon üzerinden çalışmamıza destek verin",
  ]
];

// globals
const appTitle = "Ses Ver";
const appColor = Color.fromRGBO(12, 170, 8, 1);
