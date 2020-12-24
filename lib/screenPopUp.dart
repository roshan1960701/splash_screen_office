import 'package:flutter/material.dart';

class screenPopUp extends StatefulWidget {
  @override
  _screenPopUpState createState() => _screenPopUpState();
}

class _screenPopUpState extends State<screenPopUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.90),
        body: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black26,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        print("Tapped");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://wallpaperboat.com/wp-content/uploads/2019/09/Wallpaper-for-your-vertical-mountains.jpg"),
                                fit: BoxFit.cover)),
                        /*child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                    ),*/
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
