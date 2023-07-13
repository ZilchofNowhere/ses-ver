import 'package:greenie/assets/user.dart';

class Post {
  final int id;
  final User author;
  final String content;
  final String? image;
  int likes = 0;
  List<String> comments = [];

  Post(
      {required this.id,
      required this.author,
      required this.content,
      this.image});
}
