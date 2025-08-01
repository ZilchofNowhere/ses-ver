import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenie/assets/post.dart';
import 'package:greenie/assets/user.dart';
import 'package:greenie/assets/events.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

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

final List<Event> items = [
  Event(
    author: exUser,
    image: "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
    content: "Fatih'teki çiçek bahçelerini temizliyoruz",
    location: const LatLng(41.012194, 28.979666),
  ),
  Event(
    author: exUser,
    image: "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
    content: "Mobil bir uygulama geliştiriyoruz",
    location: const LatLng(38.616324, 27.398153),
  ),
  Event(
    author: exUser,
    image: "https://zilchofnowhere.github.io/webdesign/ihsan.jpeg",
    content: "Patreon üzerinden çalışmamıza destek verin",
    location: const LatLng(36.787902, 31.430933),
  )
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
final Location location = Location();
late bool locationGranted;
