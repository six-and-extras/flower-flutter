import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './load/take_picture.dart';
import './load/upload_picture.dart';
import 'constants.dart';

Future<void> main() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  final secondCamera = cameras[1];
  runApp(MaterialApp(
    title: 'Flower2',
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MainPage(title: 'Flower2'),
      TakePictureScreen.TAG1: (context) => TakePictureScreen(camera: firstCamera),
      TakePictureScreen.TAG2: (context) => TakePictureScreen(camera: secondCamera),
      UploadPictureScreen.TAG: (context) => UploadPictureScreen(),
    },
  ));
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              // Background image.
              child: new Image.asset(
                Constants.FLOWER_BACKGROUND,
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: TakePictureScreen.TAG1,
                    onPressed: () {
                      Navigator.pushNamed(this.context, TakePictureScreen.TAG1);
                    },
                    tooltip: 'Take a rear photo',
                    child: Icon(Icons.camera),
                  ),
                  FloatingActionButton(
                    heroTag: TakePictureScreen.TAG2,
                    onPressed: () {
                      Navigator.pushNamed(this.context, TakePictureScreen.TAG2);
                    },
                    tooltip: 'Take a front photo',
                    child: Icon(Icons.camera),
                  ),
                  FloatingActionButton(
                    heroTag: UploadPictureScreen.TAG,
                    onPressed: () {
                      Navigator.pushNamed(context, UploadPictureScreen.TAG);
                    },
                    tooltip: 'Choose a photo',
                    child: Icon(Icons.photo),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
