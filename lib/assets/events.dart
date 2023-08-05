import 'package:greenie/assets/user.dart';
import 'package:latlong2/latlong.dart';

class Event {
  final User author;
  final String content;
  final String imagePath;
  final LatLng location;

  Event({
    required this.author,
    required this.content,
    required this.imagePath,
    required this.location,
  });
}
