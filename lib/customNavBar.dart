import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_little_people/models/SubscriptionPlans.dart';
import 'package:the_little_people/screens/editprofile.dart';
import 'dart:ui' as ui;
import 'package:the_little_people/screens/home.dart';
import 'package:the_little_people/screens/purchase_subscription.dart';
import 'package:the_little_people/utilities.dart';

class customNavBar extends StatefulWidget {
  /*final int cloudIndex;
  customNavBar(this.cloudIndex) : super();*/

  @override
  _customNavBarState createState() => _customNavBarState();
}

class _customNavBarState extends State<customNavBar> {


  int iconChangeHome = 0;
  String userID = "";
  PageController _myPage = PageController(initialPage: 0);


  @override
  initState() {
    super.initState();
    fetchUserId();

  }

  fetchUserId()async{
    userID = await getUserID();
    print("userid: " + userID);

  }

  Widget customNavBarItem(int num,String iconPath,Widget route,String routeName){
    return InkWell(
      child: iconChangeHome/*widget.cloudIndex*/ == num ? Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
              top: -15,
              left: -30,
              bottom: -15,
              child: SvgPicture.asset('assets/cloud.svg')),
          SvgPicture.asset('$iconPath',height: 38,width: 38,),
        ],) : SvgPicture.asset('$iconPath',height: 38,width: 38,
      ),
      onTap: (){
        /*setState(() {

        });*/
        setState(() {
          iconChangeHome = num;
          _myPage.jumpToPage(num);
        });
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => route,
              settings: RouteSettings(name: '$routeName')),
        );*/

      },
    );
  }

  Widget cloudIcon(String iconPath){
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
            top: -15,
            left: -30,
            bottom: -15,
            child: SvgPicture.asset('assets/cloud.svg')),
        SvgPicture.asset('$iconPath',height: 38,width: 38,),
      ],);
  }

  Widget itemIcon(String iconPath){
    return SvgPicture.asset('$iconPath',height: 38,width: 38,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _myPage,
        onPageChanged: (int){
          print('Page changes to index $int');
        },
        children: <Widget>[
          HomeScreen(),
          Center(
            child: Container(
              child: Text('Empty Body 1'),
            ),
          ),
          PurchaseSubscriptionScreen(),
          EditProfileScreen(userID, 'home'),
        ],
      ),
      bottomNavigationBar: Container(
        //color: Colors.grey.withOpacity(0.2),
        height: 42.33,
        // color: Colors.red,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[

            Positioned(
              bottom: -20.0,
              top: -20,
              left: -55,
              right: -55,
              child: SvgPicture.asset('assets/bottomNavPath.svg',
              ),
            ),

            Positioned(
              top: -35,
              left: 0,
              right: 0,
              bottom: -10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  customNavBarItem(0, 'assets/home-nav-icon.svg',HomeScreen(),'Home'),
                  customNavBarItem(1, 'assets/home-nav-download.svg',PurchaseSubscriptionScreen(),'subscription'),
                  customNavBarItem(2, 'assets/christmas-star.svg',PurchaseSubscriptionScreen(),'subscription'),
                  customNavBarItem(3, 'assets/home-nav-smily.svg',EditProfileScreen(userID, 'home'),'Edit profile'),
                ],
              ),
            )

          ],
        ),
      ),
    );

  }
}





