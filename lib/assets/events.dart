import 'package:greenie/assets/user.dart';

class Events {
  final User author;
  final String content;
  final String imagePath;
  // add location info

  Events(
      {required this.author, required this.content, required this.imagePath});
}
