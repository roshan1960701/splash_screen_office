import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class third extends StatefulWidget {
  @override
  _thirdState createState() => _thirdState();
}

class _thirdState extends State<third> {
  File file;
  var video;
  File fileImage;

  VideoPlayerController controller;
  bool startedPlaying = false;

  final imgUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  bool downloading = false;
  var progressString = "";

  String imageData;
  String videoData;
  bool dataLoaded = false;
  bool videoDataLoaded = false;
  @override
  void initState() {
    _asyncMethodVideo();
    //started();
    //downloadFile();
    _asyncMethod();

    super.initState();
  }

  _asyncMethod() async {
    //comment out the next two lines to prevent the device from getting
    // the image from the web in order to prove that the picture is
    // coming from the device instead of the web.
    var url =
        "https://assets.hongkiat.com/uploads/nature-photography/The-best-nature-photography-collection.jpg"; // <-- 1
    var response = await get(url); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic1.jpg';
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file2 = new File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(response.bodyBytes); // <-- 3
    fileImage = File(filePathAndName);
    setState(() {
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }

  _asyncMethodVideo() async {
    //comment out the next two lines to prevent the device from getting
    // the image from the web in order to prove that the picture is
    // coming from the device instead of the web.
    var url =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"; // <-- 1
    var response = await get(url); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/video";
    var filePathAndName = documentDirectory.path + '/video/video.mp4';
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
    }
  }

  Future<bool> started() async {
    return true;
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      print("path ${dir.path}");
      await dio.download(imgUrl, "${dir.path}/video/demo.mp4",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        video = 'file:///${dir.path}/video/demo.mp4';
        file = new File('file://${dir.path}/video/demo.mp4');

        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });

        file.exists().then((value) {
          value ? print("File Exist") : print("File not Exist");
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");

    print("FIle path:= $file");

    // controller = VideoPlayerController.file(file,
    //     videoPlayerOptions: VideoPlayerOptions());
  }

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.file(File(imageData), width: 600.0, height: 290.0),
                Container(
                    width: double.infinity,
                    height: 400,
                    child: VideoPlayer(controller)),
                FlatButton(
                    onPressed: () {
                      fileImage.exists().then((value) {
                        value
                            ? print("Image is Exist")
                            : print("Image Not Found");
                      });
                    },
                    child: Text("Check")),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.cyan,
        ),
      ));
    }

    /*return Scaffold(
      body: Center(
        child: downloading
            ? Container(
                height: 120.0,
                width: 200.0,
                child: Card(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Downloading File: $progressString",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.red,
                width: 200,
                height: 200,
                // child: VideoPlayer(controller),
              ),
      ),
    );*/
  }
}
