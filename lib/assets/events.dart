import 'package:greenie/assets/user.dart';
import 'package:latlong2/latlong.dart';

class Event {
  final User author;
  final String content;
  final String image;
  final LatLng location;
  int followers = 0;

  Event({
    required this.author,
    required this.content,
    required this.image,
    required this.location,
  });
}
