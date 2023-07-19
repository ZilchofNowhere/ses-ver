import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/user.dart';
import 'package:greenie/pages/feedpage.dart';
import 'package:greenie/pages/userpage.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navbarIndex = 0;

  var pages = [
    const FeedPage(),
    null,
    UserPage(
      user: curUser,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[navbarIndex],
      floatingActionButton: navbarIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              tooltip: 'Yeni paylaşım',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navbarIndex,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home),
            label: "Ana sayfa",
            tooltip: "Ana sayfa",
          ),
          const NavigationDestination(
            icon: Icon(Icons.search),
            label: "Arama",
            tooltip: "Arama",
          ),
          NavigationDestination(
            icon: CircleAvatar(
              backgroundImage: AssetImage(widget.user.profilePicPath!),
              radius: 12,
            ),
            label: "Hesabınız",
            tooltip: "Hesabınız",
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            navbarIndex = value;
          });
        },
      ),
    );
  }
}
