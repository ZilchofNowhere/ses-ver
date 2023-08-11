import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:greenie/assets/events.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/widgets/popupmenu.dart';
import 'package:greenie/widgets/widebutton.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final ImagePicker picker = ImagePicker();
  String? image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng location = const LatLng(39.913387, 32.851492);

  Future pickImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    String? imgPath;
    if (image != null) {
      imgPath = await uploadImage(File(image.path));
    }
    this.image = imgPath;
  }

  Future<String?> uploadImage(File img) async {
    List<int> bytes = await img.readAsBytes();
    String b64Encoded = base64Encode(bytes);

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("/upload"),
    );
    request.fields["image"] = b64Encoded;

    final response = await request.send();
    if (context.mounted) {
      if (response.statusCode == 200) {
        var decodedData = await response.stream.bytesToString();
        return decryptJWT(
            decodedData)["image"]; // path of the image in the backend
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Resminizi yüklerken bir hata meydana geldi."),
          ),
        );
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: TextStyle(
            color: appColor,
            fontFamily: "Gabriela",
          ),
        ),
        actions: const [
          AppBarPopupMenu(),
        ],
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Yeni bir etkinlik başlatın!",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _textController,
                    minLines: 3,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      label: Text("Etkinliğinizin açıklaması"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Etkinliğinizin bir açıklaması olmalı.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  WideButton(
                    elevated: false,
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text("Etkinliğinize bir resim ekleyin"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Etkinliğinizin konumunu seçin"),
                  const SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.loose(const Size(300, 300)),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: const LatLng(39.913387, 32.851492),
                        keepAlive: true,
                        onPositionChanged: (position, hasGesture) {
                          setState(() {
                            location = position.center!;
                          });
                        },
                        interactiveFlags:
                            InteractiveFlag.all ^ InteractiveFlag.rotate,
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
                              point: location,
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
                    height: 10,
                  ),
                  WideButton(
                    elevated: true,
                    onPressed: () {
                      if (_formKey.currentState!.validate() && image != null) {
                        Event post = Event(
                          author: curUser,
                          content: _textController.text.trim(),
                          image: image!,
                          location: location,
                        );
                        curUser.addEvent(post);
                        Navigator.of(context).pop();
                      } else if (image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Etkinliğinizin bir resmi olmalı."),
                          ),
                        );
                      }
                    },
                    child: const Text("Paylaşın!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
