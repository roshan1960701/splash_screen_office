import 'package:flutter/material.dart';
import 'package:social_media_widgets/instagram_story_swipe.dart';
import 'package:social_media_widgets/snapchat_dismissible.dart';
import 'package:social_media_widgets/socialmediawidgets.dart';
import 'package:splash_screen/circularPage.dart';
import 'Screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:native_updater/native_updater.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';

class page_swipe extends StatefulWidget {
  @override
  _page_swipeState createState() => _page_swipeState();
}

class _page_swipeState extends State<page_swipe> {


  @override
  void initState(){
    checkVersion();
    super.initState();
  }

  Future<void> checkVersion() async {
    int statusCode = 412;
    int localVersion = 9;
    int serverLatestVersion = 10;

    Future.delayed(Duration.zero, () {
      if (statusCode == 412) {
        NativeUpdater.displayUpdateAlert(
          context,
          forceUpdate: true,
          appStoreUrl: 'https://apps.apple.com/is/app/heycloudy-story-learning-app/id1536910417',
          playStoreUrl: 'https://play.google.com/store/apps/details?id=listen.to.heycloudy&hl=en_IN&gl=US',
          iOSDescription: 'Please update to latest version',
          iOSUpdateButtonLabel: 'Upgrade',
          iOSCloseButtonLabel: 'Exit',
        );
      } else if (serverLatestVersion > localVersion) {
        NativeUpdater.displayUpdateAlert(
          context,
          forceUpdate: false,
          appStoreUrl: '<Your App Store URL>',
          playStoreUrl: '<Your Play Store URL>',
          iOSDescription: '<Your description>',
          iOSUpdateButtonLabel: 'Upgrade',
          iOSIgnoreButtonLabel: 'Next Time',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: ()async => !Navigator.of(context).userGestureInProgress,
        child: Padding(
          padding: const EdgeInsets.only(left: 100,right: 100,top: 20,bottom: 10.0),
          child: SwipeDetector(
            onSwipeLeft: ()async{
              print("Swipe Left");
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Screen(title: "Swipe Left",color: Colors.deepOrangeAccent)));
            },
            onSwipeRight: ()async{
              print("Swipe Right");
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Screen(title: "Swipe Right",color: Colors.blueAccent)));
          },
            onSwipeUp: ()async{
              print("Swipe Up");
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Screen(title: "Swipe Up",color: Colors.tealAccent)));

            },
            onSwipeDown: ()async{
              print("Swipe Down");
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Screen(title: "Swipe Down",color: Colors.lightGreenAccent)));

            },

            child: ListView(
              children: [
                MaterialButton(
                  color: Colors.blue,
                    minWidth: 200,
                    child: Text("Social Media Swipe")
                    ,onPressed: ()async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InstagramStorySwipe(
                        children: <Widget>[
                          Screen(title: "Screen 1", color: Colors.lightBlueAccent),
                          Screen(title: 'Screen 2', color: Colors.redAccent),
                          Screen(title: 'Screen 3', color: Colors.greenAccent),
                          Screen(title: 'Screen 4', color: Colors.yellowAccent),
                          Screen(title: 'Screen 5', color: Colors.deepPurpleAccent),
                        ],
                      ),
                    ),
                  );

                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("fade")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Screen(title: "Fade",color: Colors.tealAccent,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("rightToLeft")
                    ,onPressed: ()async{

                  Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Screen(title: "RightToLeft",color: Colors.redAccent,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("leftToRight")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Screen(title: "leftToRight",color: Colors.tealAccent,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("topToBottom")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.topToBottom, child: Screen(title: "TopToBottom",color: Colors.blueAccent,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("bottomToTop")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Screen(title: "BottomToTop",color: Colors.deepOrangeAccent,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("scale")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: Screen(title: "Scale",color: Colors.amberAccent,)));

                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("rotate")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1), child: Screen(title: "Rotate",color: Colors.amberAccent,)));

                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("size")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: Screen(title: "Size",color: Colors.teal,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("rightToLeftWithFade")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Screen(title: "RightToLeftWithFade",color: Colors.deepOrangeAccent,)));
                }),
                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("leftToRightWithFade")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: Screen(title: "LeftToLeftWithFade",color: Colors.orangeAccent,)));
                }),

                MaterialButton(
                    color: Colors.blue,
                    minWidth: 200,
                    child: Text("Circular Page Transition")
                    ,onPressed: ()async{
                  Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: circularPage()));
                }),



              ],
            ),
          ),
        ),
      ),

    );
  }
}
