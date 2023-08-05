import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/user.dart';

class Event {
  final User author;
  final String content;
  final String imagePath;
  final Coordinates location;

  Event({
    required this.author,
    required this.content,
    required this.imagePath,
    required this.location,
  });
}
