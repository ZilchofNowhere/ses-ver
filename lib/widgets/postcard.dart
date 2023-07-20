import 'package:flutter/material.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/post.dart';
import 'package:greenie/pages/userpage.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likes;
  late bool likedByMe;
  late List<String> comments; // create a comment class

  @override
  void initState() {
    super.initState();
    likes = widget.post.likes;
    comments = widget.post.comments;
    likedByMe = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserPage(user: widget.post.author),
                ),
              );
            }, // navigate to the user page
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.post.author.profilePicPath!,
                      ),
                      radius: 12,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.post.author.username()),
                ],
              ),
            ),
          ),
          widget.post.image == null
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : Image.network(
                  widget.post.image!,
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.content),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      color: likedByMe ? appColor : null,
                      icon: const Icon(Icons.thumb_up_sharp),
                      onPressed: () {
                        setState(() {
                          likedByMe = !likedByMe;
                          if (likedByMe) {
                            likes++;
                            widget.post.likes++;
                          } else {
                            widget.post.likes--;
                            likes--;
                          }
                        });
                      },
                      tooltip: "Beğen",
                    ),
                    Text(likes.toString(),
                        style: TextStyle(
                          color: likedByMe
                              ? appColor
                              : IconTheme.of(context).color,
                        )),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {},
                      tooltip: "Yorumlar",
                    ),
                    Text(comments.length.toString()),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    Share.share(
                      "${widget.post.author.username()} paylaştı: ${widget.post.content}",
                    );
                  },
                  tooltip: "Paylaş",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
