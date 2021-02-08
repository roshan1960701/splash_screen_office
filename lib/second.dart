import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splash_screen/appReview.dart';
import 'package:splash_screen/download_files_service.dart';
import 'package:splash_screen/fourth.dart';
import 'package:splash_screen/ratingUI.dart';
import 'package:splash_screen/screenPopUp.dart';
import 'package:splash_screen/subscription.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:splash_screen/page_swipe.dart';
import 'package:splash_screen/third.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen/videoDownload.dart';
import 'package:package_info/package_info.dart';
import 'package:animations/animations.dart';
import 'package:splash_screen/page_transition.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:page_transition/page_transition.dart';


class second extends StatefulWidget {
  @override
  _secondState createState() => _secondState();
}

class _secondState extends State<second> with SingleTickerProviderStateMixin {
  ContainerTransitionType _containerTransitionType =
      ContainerTransitionType.fade;
  double _scale;
  AnimationController _controller;
  page_transition _page_transition = new page_transition();
  videoDownload _download = new videoDownload();
  bool show = true;
  double width = 140;
  double heihgt = 45;
  var video;
  var imagePath;
  bool checkImage;
  File fileImage;
  File data;
  VideoPlayerController controller;
  bool startedPlaying = false;
  File videoFile;

  String imageData;
  String videoData;
  bool dataLoaded = false;
  bool videoDataLoaded = false;

  appReview _appReview = new appReview();
  // final InAppReview _inAppReview = InAppReview.instance;
  // String _appStoreId = '';
  // String _microsoftStoreId = '';
  // bool _isAvailable;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    alertInfo();
    /*Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screenPopUp()));
      },
    );*/
    // controller = VideoPlayerController.file(videoFile);
    //getData();
    _appReview.widgetBinding();
    _download.downloadVideoOnline();
    // started();
    //_asyncMethodVideo();

    /*controller = VideoPlayerController.asset(videoData);
    started();*/

    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      _appReview
          .isAvailable()
          .then(
            (bool isAvailable) => setState(
              () => _isAvailable = isAvailable && !Platform.isAndroid,
            ),
          )
          .catchError(() => setState(() => _isAvailable = false));
    });*/
  }

  // Future openContainer(BuildContext context) async {
  //   await Navigator.of(context)
  //       .pushReplacement(openBuilder: (context, _) => fourth(), arguments: {
  //     'closedColor': Colors.blue,
  //     'openColor': widget.openColor,
  //     'closedElevation': widget.closedElevation,
  //     'openElevation': widget.openElevation,
  //     'closedShape': widget.closedShape,
  //     'openShape': widget.openShape,
  //     'closedBuilder': widget.closedBuilder,
  //     'openBuilder': widget.openBuilder,
  //     'hideableKey': _hideableKey,
  //     'closedBuilderKey': _closedBuilderKey,
  //     'transitionDuration': widget.transitionDuration,
  //     'transitionType': widget.transitionType,
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  showDialogCustom() async {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.90,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          print("Tapped");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                "https://wallpaperaccess.com/full/530919.jpg"),
                            fit: BoxFit.fitHeight,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -18.0,
                    right: -12.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 40.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ));
        });
  }

  alertInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool skip = (sharedPreferences.getBool('skip') ?? false);
    bool check = (sharedPreferences.getBool('check') ?? false);
    int counter;
    String appVersion =
        (sharedPreferences.getString('appVersion') ?? packageInfo.version);

    print("Version= ${packageInfo.version}");

    if (appVersion != packageInfo.version) {
      print("versions are different");
      sharedPreferences.setString('version', packageInfo.version);
      if (skip) {
        print("Skip user");
      } else {
        if (check) {
          counter = sharedPreferences.getInt('counter');
          counter++;
          print("Incremented Counter:= $counter");
          sharedPreferences.setInt('counter', counter);
        } else {
          sharedPreferences.setBool('check', true);
          sharedPreferences.setInt('counter', 1);
          counter = sharedPreferences.getInt('counter');
          //counter++;
        }
        if (counter == 4) {
          ratingAlert();
          sharedPreferences.remove('check');
          //sharedPreferences.setInt('counter', 0);
        }
      }
    } else {
      sharedPreferences.setString('version', packageInfo.version);
      print("versions are Same");
      if (skip) {
        print("Skip user");
      } else {
        if (check) {
          counter = sharedPreferences.getInt('counter');
          counter++;
          print("Incremented Counter:= $counter");
          sharedPreferences.setInt('counter', counter);
        } else {
          sharedPreferences.setBool('check', true);
          sharedPreferences.setInt('counter', 1);
          counter = sharedPreferences.getInt('counter');
          // counter++;
        }
        if (counter == 4) {
          ratingAlert();
          sharedPreferences.remove('check');
          //sharedPreferences.setInt('counter', 0);
        }
      }
    }

    // counter = sharedPreferences.getInt('counter');
    // print("GetCounter:= $counter");
  }

  ratingAlert() async {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Rating Alert!!"),
            content: Text(
                "If you really liked our app so please give us ratings on PlayStore!!!"),
            actions: [
              FlatButton(onPressed: () {}, child: Text("Rate")),
              FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    SharedPreferences sharedPreference =
                        await SharedPreferences.getInstance();
                    sharedPreference.setBool('skip', true);
                  },
                  child: Text("Skip")),
            ],
          );
        });
  }

  _asyncMethodVideo() async {
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

    setState(() {
      videoData = filePathAndName;
      fileImage = File(filePathAndName);
      print("video path:= file:/$videoData");
      videoDataLoaded = true;
    });

    if (await fileImage.exists()) {
      sharedPreferences.setString('videoLink', videoData);
      print("Video FIle Exist");

      String videoData2 = sharedPreferences.getString('videoPath');

      controller = VideoPlayerController.file(File(videoData2));
      await controller.initialize();
      await controller.play();
      startedPlaying = true;
    }
  }

  /*void _setAppStoreId(String id) => _appStoreId = id;

  void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );*/

  Future<bool> started() async {
    await controller.initialize();
    await controller.play();
    startedPlaying = true;
    return true;
  }

  getData() async {
    setState(() async {
      imagePath = await downloadImageFile(
          "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg");
      data = new File(imagePath);
    });
    data.exists().then((value) {
      value ? print("Image Exist") : print("Image Not found");
      setState(() {
        checkImage = value;
      });
    });
    // video = await downloadVideoFile(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4/download?force=true");
    //
    // // print("String Video File:= " + video);
    //
    // videoFile = new File(video);
    //
    // videoFile.exists().then((value) {
    //   value ? print("File Exist") : print("File Not Exist");
    // });
    //
    // print("File Location" + video);
    // controller = VideoPlayerController.file(videoFile);
  }

  Widget get _animatedButtonUI => Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0000FF),
                Color(0xFFFF3500),
              ],
            )),
        child: Center(
          child: Text(
            'tap',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  Widget customContainer() {
    return Container(
      color: Colors.orange,
      child: Center(
        child: FlutterLogo(
          size: 300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    /*const loadingMessage = 'LOADING';
    const availableMessage = 'AVAILABLE';
    const unavailableMessage = 'UNAVAILABLE';*/
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "AppBar",
        // overflow: TextOverflow.ellipsis,
        // softWrap: false,
      )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Image.network(
                "https://i.pinimg.com/736x/50/df/34/50df34b9e93f30269853b96b09c37e3b.jpg",
                width: 100.0,
                height: 100.0,
              ),
              /*videoDataLoaded
                  ? Container(
                      width: double.infinity,
                      height: 300,
                      child: VideoPlayer(controller),
                    )
                  : Text("Hello"),*/
              /*Text(
                'InAppReview status: ${_isAvailable == null ? loadingMessage : _isAvailable ? availableMessage : unavailableMessage}',
              ),
              TextField(
                onChanged: _setAppStoreId,
                decoration: InputDecoration(hintText: 'App Store ID'),
              ),
              TextField(
                onChanged: _setMicrosoftStoreId,
                decoration: InputDecoration(hintText: 'Android App Store ID'),
              ),
              RaisedButton(
                onPressed: () async {
                  if (await _inAppReview.isAvailable()) {
                    _inAppReview.requestReview();
                  }
                },
                child: Text('Request Review'),
              ),*/
              RaisedButton(
                onPressed: () {
                  _appReview.openStoreListing();
                },
                child: Text('Open Store Listing'),
              ),
              RaisedButton(
                onPressed: () {
                  _appReview.requestReview();
                },
                child: Text('App Review'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: fourth()));
                },
                child: Text("Video Demo"),
              ),
              MaterialButton(
                onPressed: () {
                  showDialogCustom();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => screenPopUp()));
                },
                child: Text("Alert Dialog"),
              ),
              MaterialButton(
                onPressed: () async {
                  ratingAlert();
                },
                child: Text("Rating Dialog"),
              ),

              MaterialButton(
                color: Colors.amberAccent,
                elevation: 20.0,
                minWidth: 80,
                height: 40,
                onPressed: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          child: subscription(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200 )));
                },
                child: Text("UI"),
              ),

              InkWell(
                onTap: () {
                  Future.delayed(Duration(milliseconds: 400), () {
                    setState(() {
                      width = 60;
                      heihgt = 30;
                    });
                  }).whenComplete(() {
                    setState(() {
                      width = 150;
                      heihgt = 50;
                    });
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    width = 120;
                    heihgt = 40;
                  });
                },
                child: AnimatedContainer(
                  height:
                      heihgt, // height is 100 when show is true and when show is false height is 200
                  width:
                      width, // width is 200 when show is true and when show is false height is 100
                  decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInCirc,
                  child: Center(
                      child: Text(
                    "Click",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),

              OpenContainer(
                  useRootNavigator: true,
                  openColor: Colors.green,
                  transitionType: ContainerTransitionType.fade,
                  transitionDuration: Duration(milliseconds: 800),
                  openBuilder: (context, _) => fourth(),
                  closedElevation: 1.0,
                  openElevation: 50.0,
                  /*openShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: BorderSide(color: Colors.white, width: 1)),*/
                  closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: BorderSide(color: Colors.white, width: 1)),
                  closedColor: Colors.red,
                  closedBuilder: (context, _) => Container(
                      //color: Colors.indigoAccent,
                      alignment: Alignment.center,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Container Transition",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                  )
              ),
              /*Center(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
              ),*/

              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: page_transition(),
                            type: PageTransitionType.fade,
                            duration: Duration(seconds: 1)));
                  },
                  color: Colors.cyan,
                  child: Text("Animate Button"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(SwipeablePageRoute(
                      onlySwipeFromEdge: true,
                      builder: (BuildContext context) => page_swipe(),
                    ));
                  },
                  color: Colors.cyan,
                  child: Text("Page swipe"),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => page_swipe(),
                    ),
                    );
                  },
                  color: Colors.cyan,
                  child: Text("Page Test"),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () async{

                    String url = "https://apps.apple.com/is/app/heycloudy-story-learning-app/id1536910417";
                    String url1 = "https://play.google.com/store/apps/details?id=listen.to.heycloudy&hl=en_IN&gl=US";
                    if(await canLaunch(url)){
                    // await launch(url);
                      IosAlertDialog();
                    }
                    else{
                    print("cannot launch");
                    }

                  },
                  color: Colors.deepOrangeAccent,
                  child: Text("Remote config"),
                ),
              ),

              // Image.file(File(imagePath)),
              // checkImage ? Image.asset(imagePath) : Text("No image Found"),
            ],
          ),
        ),
      ),
    );
  }

  Future IosAlertDialog()async{
    return showDialog(
        barrierDismissible: false,
        context: context,
      builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text("HeyCloudy Update Available!"),
            content: Text("There is newer version of this app available"),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: ()async{
                  exit(0);
                },
                child: Text("Exit"),
              ),
              CupertinoDialogAction(
                onPressed: ()async{
                      String url = "https://apps.apple.com/is/app/heycloudy-story-learning-app/id1536910417";
                      String url1 = "https://play.google.com/store/apps/details?id=listen.to.heycloudy&hl=en_IN&gl=US";
                      if(await canLaunch(url)){
                        await launch(url);
                      }
                },
                child: Text("Update"),
              ),
            ],
          );
      }

    );
  }
}
