import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class videoDownload {
  downloadVideoOnline() async {
    String videoData;
    File fileImage;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"; // <-- 1
    var response = await get(url); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/video";
    var filePathAndName = documentDirectory.path + '/video/video1.mp4';
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file2 = new File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(response.bodyBytes); // <-- 3
    // fileImage = File(filePathAndName);
    videoData = filePathAndName;
    fileImage = File(filePathAndName);
    print("video path:= file:/$videoData");

    /*setState(() {
      videoData = filePathAndName;
      fileImage = File(filePathAndName);
      print("video path:= file:/$videoData");
      //videoDataLoaded = true;
    });*/

    if (await fileImage.exists()) {
      sharedPreferences.setString('videoLink', videoData);
      print("Video FIle Exist");

      String videoData2 = sharedPreferences.getString('videoLink');
      print(videoData2);

      /*controller = VideoPlayerController.file(File(videoData2));
      await controller.initialize();
      await controller.play();
      startedPlaying = true;*/
    }
  }
}
