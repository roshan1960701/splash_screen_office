import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen/appReview.dart';
import 'package:package_info/package_info.dart';


class appRate{

  appReview _appReview = new appReview();

  ratingAlert(BuildContext context, String value, String version) async {
    _appReview.widgetBinding();
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Rating Alert!!"),
            content: Text(
                "If you really liked our app so please give us ratings on PlayStore!!!"),
            actions: [
              FlatButton(onPressed: () async {
                _appReview.openStoreListing();
                SharedPreferences sharedPreference = await SharedPreferences
                    .getInstance();
                sharedPreference.setString('rateDate', value);
                sharedPreference.setString('appVersion', version);
                Navigator.pop(context);
              }, child: Text("Rate")),
              FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    SharedPreferences sharedPreference = await SharedPreferences
                        .getInstance();
                    sharedPreference.setString('rateDate', value);
                  },
                  child: Text("Later")),
            ],
          );
        });
  }

  getRateInfo(BuildContext context) async {
    //var todaysDate = DateTime.now().toString();
    var parseDate = DateTime.parse(DateTime.now().toString());
    var nextDate = DateTime.utc(
        parseDate.year, parseDate.month, parseDate.day + 15).toString();

    print("Next Date $nextDate");

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var rateDate = sharedPreferences.getString('rateDate') ?? '';
    print("rate Date: $rateDate");
    if (rateDate.isEmpty) {
      sharedPreferences.setString('rateDate', nextDate);
      sharedPreferences.setString('appVersion', packageInfo.version);
    }
    else {
      if (rateDate.compareTo(DateTime.now().toString()) >= 0) {
        //check version code available
        var appVersion = sharedPreferences.getString('appVersion') ?? '';
        if (appVersion.isNotEmpty) {
          print("app version is not Empty");
          //check it with current app version

          print("app version: $appVersion");

          if (appVersion == packageInfo.version) {
            print("Nothing!!");
            //Dont show pop up
          }
          else {
            //Show pop up
            print("first else");
            ratingAlert(context,nextDate, packageInfo.version);
          }
        }
        else {
          //not available show pop up
          print("second else");
          // ratingAlert(nextDate,packageInfo.version);
        }
      }
      else {
        //do Nothing
        print("Date Expired");
        ratingAlert(context,nextDate, packageInfo.version);
      }
    }



  }
}