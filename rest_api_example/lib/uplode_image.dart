import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImagePickerAPI extends StatefulWidget {
  const ImagePickerAPI({super.key});

  @override
  State<ImagePickerAPI> createState() => _ImagePickerAPIState();
}

class _ImagePickerAPIState extends State<ImagePickerAPI> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final PickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      setState(() {});
    } else {
      print("no Image Selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse("https://fakestoreapi.com/products");

    var request = http.MultipartRequest("POST", uri);
    request.fields["title"] = "Static title";

    var multiPort = http.MultipartFile(
      "image",
      stream,
      length,
    );

    request.files.add(multiPort);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("image Uploaded");
    } else {
      setState(() {
        showSpinner = false;
      });
      print('Faild');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                child: image == null
                    ? const Center(
                  child: Text("Pick Image"),
                )
                    : Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: const Text("Upload"))
          ],
        ),
      ),
    );
  }
}