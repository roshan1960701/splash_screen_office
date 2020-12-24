import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> downloadVideoFile(String url) async {
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir = (await getApplicationDocumentsDirectory()).path + '/video';

  if ((await Directory(dir).exists()) != true) {
    final directory = await Directory(dir).create(recursive: true);
    print(directory.path);
    dir = directory.path;
  }

  String filename = url.split('/').last;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return 'file://$dir/$filename';
}

Future<File> downloadVideo() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String url =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir = (await getApplicationDocumentsDirectory()).path + '/video';

  if ((await Directory(dir).exists()) != true) {
    final directory = await Directory(dir).create(recursive: true);
    print(directory.path);
    dir = directory.path;
  }

  String filename = url.split('/').last;
  File file = new File('$dir/$filename');
  sharedPreferences.setString('downloadVideo', file.toString());
  await file.writeAsBytes(bytes);
  return file;
}

// Future<Uint8List> getVideo() async {
//   String dir =
//       (await getApplicationDocumentsDirectory()).path + '/video/butterfly.mp4';
//
//   if ((await Directory(dir).exists()) == true) {
//     final directory = await Directory(dir).create(recursive: true);
//     print(directory.path);
//     dir = directory.path;
//   }
//   File file;
//   file = await downloadVideo();
//   File mp4 = await file.read();
//   await file.readAsBytes();
//   return mp4;
//   print('FileName:= $dir');
//
//   // File file = new File('$dir');
//   // return file;
// }

Future<String> downloadAudioFile(String url) async {
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir =
      (await getApplicationDocumentsDirectory()).path + '/asset/audios';

  if ((await Directory(dir).exists()) != true) {
    final directory = await Directory(dir).create(recursive: true);
    print(directory.path);
    dir = directory.path;
  }

  String filename = url.split('/').last;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return '$dir/$filename';
}

Future<String> downloadImageFile(String url) async {
  http.Client client = new http.Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir =
      (await getApplicationDocumentsDirectory()).path + '/asset/images';

  if ((await Directory(dir).exists()) != true) {
    final directory = await Directory(dir).create(recursive: true);
    print(directory.path);
    dir = directory.path;
  }

  String filename = url.split('/').last;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return 'file://$dir/$filename';
}

Future<bool> deleteFile(String url) async {
  try {
    File file = new File(url);
    await file.delete(recursive: true);
    return true;
  } catch (e) {
    print('error in file deletion : $url');
    print(e.toString());
    return false;
  }
}
