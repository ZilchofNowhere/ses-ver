import 'package:greenie/assets/events.dart';
import 'package:greenie/assets/post.dart';

class User {
  final String name;
  final String email;
  String? profilePicPath = "assets/images/defaultpfp.png";
  String? token;
  List<Post> posts = [];
  List<Event> events = [];
  List<Post> likedPosts = [];

  User({
    required this.name,
    required this.email,
    this.profilePicPath,
    this.token,
  });

  String username() {
    return "@$name";
  }

  void addPost(Post post) {
    posts.add(post);
  }

  void addEvent(Event event) {
    events.add(event);
  }

  Future reportUser() async {}
}
