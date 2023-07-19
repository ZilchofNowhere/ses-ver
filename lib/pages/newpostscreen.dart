import 'package:flutter/material.dart';
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
  XFile? image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  Future<String> pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    return image!.path;
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
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            pickImage();
                            // get the image path (you cant use .then())
                            // and upload the image to the server
                            // (i think i could unite the two in one func)
                            // and finally assign it to the resulting post
                          },
                          child: const Text("Paylaşımınıza bir resim ekleyin"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Post post = Post(
                                id: 1,
                                author: curUser,
                                content: _textController.text.trim(),
                                // image:
                              );
                              curUser.addPost(post);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Paylaşın!"),
                        ),
                      ),
                    ],
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
