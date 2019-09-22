import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './camera/photos.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower2',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MainPage(title: 'Flower2'),
    );
  }
}

Future navigateToSubPage(context) async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)));
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            navigateToSubPage(context);
          },
        tooltip: 'Take a photo',
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
