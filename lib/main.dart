import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splash_screen/download_files_service.dart';
import 'package:splash_screen/second.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String videoPath = sharedPreferences.getString('videoLink');
  runApp(MyApp(videoPath: videoPath));
}

class MyApp extends StatelessWidget {
  final String videoPath;
  MyApp({Key key, @required this.videoPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen Demo App',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: MyHomePage(videoPath: videoPath),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String videoPath;
  MyHomePage({Key key, this.videoPath}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(videoPath: videoPath);
}

class _MyHomePageState extends State<MyHomePage> {
  String videoPath;
  _MyHomePageState({this.videoPath});
  VideoPlayerController controller;
  bool startedPlaying = false;

  File file;
  var video;
  File fileImage;

  String imageData;
  String videoData;
  String videoData1 = " ";
  bool dataLoaded = false;
  bool videoDataLoaded = false;

  bool checkData = false;

  @override
  void initState() {
    check();
    //getData();
    // controller = VideoPlayerController.asset("asset/HeyCloudy.mp4");
    // started();
    // controller.addListener(() {
    //   if (startedPlaying && !controller.value.isPlaying) {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => second()));
    //   }
    // });

    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    File file = await downloadVideo();
    print('file path: $file');
    if (await file.exists()) {
      setState(() {
        checkData = true;
      });
      controller = VideoPlayerController.file(file);
      await controller.initialize();
      await controller.play();
      startedPlaying = true;

      controller.addListener(() {
        if (startedPlaying && !controller.value.isPlaying) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => second()));
        }
      });
    } else {
      controller = VideoPlayerController.asset("asset/HeyCloudy.mp4");
    }
  }

  check() async {
    print("Shared Preference: $videoPath");
    setState(() {
      checkData = true;
    });

    if (videoPath == null || videoPath.length == null) {
      controller = VideoPlayerController.asset("asset/HeyCloudy.mp4");
    } else {
      controller = VideoPlayerController.file(File(videoPath));
      //started();
    }

    controller.initialize();
    controller.play();
    startedPlaying = true;
    controller.addListener(() {
      if (startedPlaying && !controller.value.isPlaying) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => second()));
      }
    });
  }

  Future<bool> started() async {
    await controller.initialize();
    await controller.play();
    startedPlaying = true;
    return true;
  }

  _asyncMethodVideo() async {
    var url =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"; // <-- 1
    var response = await get(url); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/video";
    var filePathAndName = documentDirectory.path + '/video/splash.mp4';
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file2 = new File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(response.bodyBytes); // <-- 3
    // fileImage = File(filePathAndName);
    setState(() {
      videoData = filePathAndName;
      fileImage = File(filePathAndName);
      print("video path:= file:/$videoData");
      videoDataLoaded = true;
    });

    if (await fileImage.exists()) {
      print("Video FIle Exist");
      controller = VideoPlayerController.file(File(videoData));
      await controller.initialize();
      await controller.play();
      startedPlaying = true;

      controller.addListener(() {
        if (startedPlaying && !controller.value.isPlaying) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => second()));
        }
      });
      //started();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF35c1f0), Color(0xFFbce7f5)])
          /*image: DecorationImage(
          image: new ExactAssetImage("asset/logo/launch.jpg"),
        ),*/
          ),
      child: checkData
          ? VideoPlayer(controller)
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF35c1f0), Color(0xFFbce7f5)])),
            ),
    )

            /*Stack(
        children: [
          Image.asset(
            "asset/logo/launch.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                VideoPlayer(controller),
              ],
            ),
          )
        ],
      ),*/
            ));
  }
}
