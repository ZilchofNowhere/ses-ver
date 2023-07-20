// find a way to add its own app bar
import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/user.dart';
import 'package:greenie/widgets/popupmenu.dart';
import 'package:greenie/widgets/postcard.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({super.key, required this.user});

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              leading: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  user.profilePicPath!,
                ),
              ),
              title: Text(
                user.username(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                "${user.posts.length} paylaşım",
              ), // add joined activites and stuff
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 8.0),
            child: Text(
              "Paylaşımları",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          user.posts.isEmpty
              ? const Center(
                  child: Text("Henüz bir şey paylaşmamış."),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...(user.posts.map(
                        (post) => PostCard(
                          post: post,
                        ),
                      )),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
