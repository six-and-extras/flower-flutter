import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPictureScreen extends StatefulWidget {
  static const String TAG = 'uploadPicture';

  @override
  _UploadPictureScreenState createState() => _UploadPictureScreenState();
}

class _UploadPictureScreenState extends State<UploadPictureScreen> {
  Future<File> imageFile;
  @override
  void initState() {
    super.initState();
    pickImageFromGallery(ImageSource.gallery);
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            // Image selected from gallery.
            snapshot.data,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error picking image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No image selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload an image'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        showImage(),
        FloatingActionButton(
          heroTag: "backToHomeScreenFromUploadScreen",
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Go back',
          child: Icon(Icons.arrow_back_ios),
        ),
      ])),
    );
  }
}
