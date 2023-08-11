import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenie/widgets/widebutton.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:greenie/assets/globals.dart';
import 'package:greenie/assets/post.dart';
import 'package:greenie/widgets/popupmenu.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final ImagePicker picker = ImagePicker();
  String? image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

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
                    "Yeni bir şey paylaşın!",
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
                      label: Text("Paylaşımınızın içeriği"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Paylaşımınızın bir metni olmalı.";
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
                    child: const Text("Paylaşımınıza bir resim ekleyin"),
                  ),
                  WideButton(
                    elevated: true,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Post post = Post(
                          id: 1,
                          author: curUser,
                          content: _textController.text.trim(),
                          image: image,
                        );
                        curUser.addPost(post);
                        Navigator.of(context).pop();
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
