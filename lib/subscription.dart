import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen/appReview.dart';
import 'package:package_info/package_info.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart'; // for other locales

class subscription extends StatefulWidget {
  @override
  _subscriptionState createState() => _subscriptionState();
}

class _subscriptionState extends State<subscription> {

  final GlobalKey _cardKey = GlobalKey();
  Size cardSize;
  Offset cardPosition;
  double height,width;
  appReview _appReview = new appReview();

  

  @override
  void initState() {
    super.initState();
    _appReview.widgetBinding();
    alertInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  customTextStyle(fontSize,fontWeight,color){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
    );
  }
  
  alertInfo() async{

    var todaysDate = DateTime.now().toString();
    print("Todays Date: $todaysDate");
    //todaysDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    //print("Todays Date:"+DateFormat("yyyy-MM-dd").format(DateTime.now()));

    var parseDate = DateTime.parse(todaysDate);
    var nextDate = DateTime.utc(parseDate.year,parseDate.month,parseDate.day+15).toString();
    print("Next Date $nextDate");

    /*print("Date Type ${nextDate.runtimeType}");
    print("NextDate: "+DateFormat("yyyy-MM-dd").format(nextDate));
    print("Next Date: $nextDate");*/

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var  rateDate = sharedPreferences.getString('rateDate') ?? '';
    print("rate Date: $rateDate");
    //var appVersion = sharedPreferences.getString('appVersion')?? " ";
    
    if(rateDate.isEmpty){
      sharedPreferences.setString('rateDate', nextDate);
     sharedPreferences.setString('appVersion',packageInfo.version);

    }
    else{
         if(rateDate.compareTo(DateTime.now().toString())>=0){
           //check version code available
           var appVersion = sharedPreferences.getString('appVersion') ?? '';
           if(appVersion.isNotEmpty){

             print("app version is not Empty");
             //ratingAlert(nextDate, packageInfo.version);
              //check it with current app version

             //var appVersion = sharedPreferences.getString('appVersion');
             print("app version: $appVersion");

              if(appVersion == packageInfo.version){
                print("Nothing!!");
                //Dont show pop up
              }
              else{
                //Show pop up
                print("first else");
                ratingAlert(nextDate, packageInfo.version);
              }

           }
           else{
             //not available show pop up
             print("second else");
            // ratingAlert(nextDate,packageInfo.version);
           }


         }
        else {
           //do Nothing
           print("Date Expired");
          ratingAlert(nextDate,packageInfo.version);
         }
    }





/*
    bool check = (sharedPreferences.getBool('check') ?? false);
    if(!check){
      sharedPreferences.setString('appInstalledDate', DateFormat("yyyy-MM-dd").format(DateTime.now()));
      sharedPreferences.setString('RateUsDate',DateFormat("yyyy-MM-dd").format(nextDate));
      sharedPreferences.setBool('check', true);
    }
    else{
      sharedPreferences.setBool('check', true);
      var appInstalledDate =  sharedPreferences.getString('appInstalledDate');
      var rateDate = sharedPreferences.getString('RateUsDate');

      if(appInstalledDate == rateDate){
        //Display popup
        //store next 15 days date
      }

    }*/

/*
    var appInstalledDate = (sharedPreferences.getString('appInstalledDate' ?? DateFormat("yyyy-MM-dd").format(DateTime.now())));
    var getAppInstalledDate = sharedPreferences.getString('appInstalledDate');

    var ratingDate = (sharedPreferences.getString(DateFormat("yyyy-MM-dd").format(nextDate) ?? ' '));
*/


  }

  ratingAlert(String value,String version) async {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Rating Alert!!"),
            content: Text(
                "If you really liked our app so please give us ratings on PlayStore!!!"),
            actions: [
              FlatButton(onPressed: () async{
                _appReview.openStoreListing();
                SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                sharedPreference.setString('rateDate', value);
                sharedPreference.setString('appVersion', version);
                Navigator.pop(context);

              }, child: Text("Rate")),
              FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                    sharedPreference.setString('rateDate', value);

                  },
                  child: Text("Later")),
            ],
          );
        });
  }

  double _calculateWX(double x) {
    double baseWidth = 360;

    double deviceWidth = MediaQuery.of(context).size.width;

    return x = ((x * deviceWidth) / baseWidth);
  }

  double _calculateHY(double y) {
    double baseHeight = 640;

    double deviceHeight = MediaQuery.of(context).size.height;

    return y = ((y * deviceHeight) / baseHeight);
  }

  getSizeAndPosition() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    RenderBox _cardBox = _cardKey.currentContext.findRenderObject();
    cardSize = _cardBox.size;
    cardPosition = _cardBox.localToGlobal(Offset.zero);
    print(cardSize.width);
    print(cardPosition);
    print("Media Height= $height");
    print("Media Width= $width");
    print(width-200);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.lightBlueAccent,

      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 201,
                  child: Stack(
                    children: [
                      Image.asset('asset/home-header.png',
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Image.asset('asset/cloud-header.png',
                          //key: _cardKey,
                          width: MediaQuery.of(context).size.width,
                        ),),
                      Positioned(
                        top: 140,
                        left: 48,
                        child: SvgPicture.asset('asset/download_unsubscribed.svg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],

                  ),

                ),


                /*Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Image.asset('asset/cloud-header.png',
                  key: _cardKey,
                  width: MediaQuery.of(context).size.width,
                ),),*/


                Padding(padding: EdgeInsets.only(top: 210),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Positioned(
                      bottom: 0.0,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(padding: EdgeInsets.only(top: 10,left: 15.0),
                                child: Text("Get Premium",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 25.0,right: 25.0),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color(0XFFE8E8E8),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Hey Cloudy FREE",style: TextStyle(
                                        fontSize: 18  ,
                                        fontWeight: FontWeight.w400,

                                      ),),
                                      Text("Current Plan",style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 230,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFFFF8AE1),Color(0xFFDD5CF6),Color(0xFFCE48FF)]
                                  )
                                ),
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Positioned(
                                        top: 10,
                                        left: -30,
                                        child:Image.asset('asset/cloud.png',
                                      fit: BoxFit.fill,
                                      width: 120,
                                    )),

                                    Positioned(
                                        bottom: 30,
                                        right: -30,
                                        child:Image.asset('asset/cloud.png',
                                          fit: BoxFit.fill,
                                          width: 120,
                                        )),
                                    Positioned(
                                    top:25,
                                    left: 25
                                    ,child: Text("FOR 1 MONTH",style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),)),
                                    Positioned(
                                        top:25,
                                        right: 95,
                                        child: Text('₹199',style: customTextStyle(30.0, FontWeight.bold, Colors.white))),

                                    Positioned(
                                      top: 35,
                                      right: 30,
                                      child: Text(
                                        "₹249",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.lineThrough,
                                          decorationThickness: 2.0
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 80,
                                        child:Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text("Unlimited Audio Stories & Music Access Brian-",
                                                  style: customTextStyle(16.0, FontWeight.normal, Colors.white),
                                                ),
                                                Text("Ticking Puzzles. Uninterrupted Listening. Download",
                                                  style: customTextStyle(16.0, FontWeight.normal, Colors.white),
                                                ),
                                                Text(" 100 Audios/devices",
                                                  style: customTextStyle(16.0, FontWeight.normal, Colors.white),
                                                )
                                              ],

                                            ),
                                          ),
                                        )
                                    ),

                                    Positioned(
                                      bottom: 20.0,
                                      left: 80,
                                      right: 80,
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(100),
                                          boxShadow: [
                                            new BoxShadow(
                                              color: Color(0xFF962CFF),
                                              offset: Offset(0,3)

                                            ),
                                          ]

                                        ),
                                        child: Center(child: Text("SUBSCRIBE NOW",style: customTextStyle(16.0, FontWeight.bold,Color(0xFFDD5CF6)),)),
                                      ),
                                    )

                                      /*RichText(text: TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                              text: "Unlimited Audio Stories & Music Access Brian-Ticking Puzzles. Uninterrupted Listening. Download 100 Audios/devices",
                                              style: customTextStyle(18.0, FontWeight.normal, Colors.white)

                                            ),
                                            *//*new TextSpan(
                                                text: "Ticking Puzzles. Uninterrupted Listening. Download",
                                                style: customTextStyle(18.0, FontWeight.normal, Colors.white)

                                            ),
                                            new TextSpan(
                                                text: "100 Audios/devices",
                                                style: customTextStyle(18.0, FontWeight.normal, Colors.white)

                                            ),*//*
                                          ]
                                        )*/

                                        /*))*/
                                  ],
                                ),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 230,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Color(0xFF75D9FF),Color(0xFF58F1F4),Color(0xFF48FFED)]
                                    )
                                ),
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Positioned(
                                        top: 10,
                                        left: -30,
                                        child:Image.asset('asset/cloud.png',
                                          fit: BoxFit.fill,
                                          width: 120,
                                        )),

                                    Positioned(
                                        bottom: 30,
                                        right: -30,
                                        child:Image.asset('asset/cloud.png',
                                          fit: BoxFit.fill,
                                          width: 120,
                                        )),
                                    Positioned(
                                        top:25,
                                        left: 25
                                        ,child: Text("FOR 1 MONTH",style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),)),
                                    Positioned(
                                        top:25,
                                        right: 95,
                                        child: Text('₹199',style: customTextStyle(30.0, FontWeight.bold, Colors.white))),

                                    Positioned(
                                      top: 35,
                                      right: 30,
                                      child: Text(
                                        "₹249",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.lineThrough,
                                            decorationThickness: 2.0
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 80,
                                        child:Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text("Unlimited Audio Stories & Music Access Brian-",
                                                  style: customTextStyle(16.0, FontWeight.normal, Colors.white),
                                                ),
                                                Text("Ticking Puzzles. Uninterrupted Listening. Download",
                                                  style: customTextStyle(16.0, FontWeight.normal, Colors.white),
                                                ),
                                                Text(" 100 Audios/devices",
                                                  style: customTextStyle(16.0, FontWeight.normal, Colors.white),
                                                )
                                              ],

                                            ),
                                          ),
                                        )
                                    ),

                                    Positioned(
                                      bottom: 20.0,
                                      left: 80,
                                      right: 80,
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(100),
                                            boxShadow: [
                                              new BoxShadow(
                                                  color: Color(0xFF00EFDA),
                                                  offset: Offset(0,3)

                                              ),
                                            ]

                                        ),
                                        child: Center(child: Text("SUBSCRIBE NOW",style: customTextStyle(16.0, FontWeight.bold,Color(0xFF58F1F4)),)),
                                      ),
                                    )

                                    /*RichText(text: TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                              text: "Unlimited Audio Stories & Music Access Brian-Ticking Puzzles. Uninterrupted Listening. Download 100 Audios/devices",
                                              style: customTextStyle(18.0, FontWeight.normal, Colors.white)

                                            ),
                                            *//*new TextSpan(
                                                text: "Ticking Puzzles. Uninterrupted Listening. Download",
                                                style: customTextStyle(18.0, FontWeight.normal, Colors.white)

                                            ),
                                            new TextSpan(
                                                text: "100 Audios/devices",
                                                style: customTextStyle(18.0, FontWeight.normal, Colors.white)

                                            ),*//*
                                          ]
                                        )*/

                                    /*))*/
                                  ],
                                ),

                              ),
                            ),


                          ],

                        ),
                      ),
                    ),
                  ),
                )

              ],
            )
            /*Positioned(
              top: 60,
              child: Column(
                children: [
                  Image.asset('asset/cloud-header.png',
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Colors.amber,
                  )

                ],

              ),
            ),*/


          ],
        )
            /*child: Stack(
              children: [
                Positioned(
                  top: 160,
                  child: Image.asset("asset/cloud-header.png",width: MediaQuery.of(context).size.width,),
                )
              ],
            ),*/

      ),

    );
  }
}
