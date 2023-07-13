import 'package:flutter/material.dart';
import 'package:greenie/assets/post.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/user.dart';
import 'package:greenie/widgets/carousel.dart';
import 'package:greenie/widgets/postcard.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarOpacity: 0.6,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundImage: AssetImage(widget.user.profilePicPath!),
              radius: 50,
            ),
            tooltip: "Hesabınız",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: "Arama",
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            tooltip: "Fotoğraf çekin",
          ),
        ],
        title: const Text(
          appTitle,
          style: TextStyle(
            fontFamily: "Gabriela",
            color: appColor,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 8.0),
              child: Text(
                "Size yakın etkinlikler",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Carousel(items: items),
            const Padding(
              padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 8.0),
              child: Text(
                "Akışınız",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ...(List.from([0, 1, 2, 3, 4].map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: PostCard(
                  post: Post(
                    id: e,
                    author: exUser,
                    content:
                        "Ben doğada çok eğleniyorum, siz orada zaman geçirmek istemez misiniz?",
                    image: e % 2 == 1 ? null : "assets/images/toprow.png",
                  ),
                ),
              ),
            ))),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Yeni paylaşım',
        child: const Icon(Icons.add),
      ),
    );
  }
}
