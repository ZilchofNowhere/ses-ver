import 'package:flutter/material.dart';
import 'package:greenie/assets/events.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/widgets/popupmenu.dart';
import 'package:flutter_map/flutter_map.dart';

class EventPage extends StatefulWidget {
  final Event event;
  const EventPage({super.key, required this.event});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: TextStyle(
            fontFamily: "Gabriela",
            color: appColor,
          ),
        ),
        actions: const [
          AppBarPopupMenu(),
        ],
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Image.network(
                widget.event.image,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.event.content,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Etkinliğin konumu",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.loose(const Size(500, 500)),
                child: FlutterMap(
                  options: MapOptions(
                    center: widget.event.location,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.sesver.sesver',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: widget.event.location,
                          width: 80,
                          height: 80,
                          builder: (context) => const Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
