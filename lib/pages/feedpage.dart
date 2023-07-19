import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/post.dart';
import 'package:greenie/widgets/carousel.dart';
import 'package:greenie/widgets/popupmenu.dart';
import 'package:greenie/widgets/postcard.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            tooltip: "Fotoğraf çekin",
          ),
          const AppBarPopupMenu(),
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
                        "Ben doğada çok eğleniyorum, siz de orada zaman geçirmek istemez misiniz?",
                    image: e % 2 == 1 ? null : "assets/images/toprow.png",
                  ),
                ),
              ),
            ))),
            const SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}
