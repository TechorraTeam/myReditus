import 'package:flutter/material.dart';

import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/EnterAddressPage.dart';
import 'package:reditus/widgets/EnterEmailCodePage.dart';
import 'package:reditus/widgets/EnterPasswordPage.dart';
import 'package:reditus/widgets/EnterTestNumberPage.dart';
import 'package:reditus/widgets/HelloBeginPage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/LoginPage.dart';
import 'package:reditus/widgets/MainPageTestVisit.dart';
import 'package:reditus/widgets/QuestionAnswerCompletedPage.dart';
import 'package:reditus/widgets/QuestionAnswerPage.dart';
import 'package:reditus/widgets/ReportSendPage.dart';
import 'package:reditus/widgets/TemperatureMeasuringPage.dart';
import 'package:reditus/widgets/TestTakePicturePage.dart';
import 'package:reditus/widgets/ThankYouHomePage.dart';
import 'package:reditus/widgets/WorkLocationPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool dataAvailable = false;
  @override
  void initState() {
    super.initState();

    getJsonData().then((val){
      setState(() {
        dataAvailable = val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reditus',
      home: dataAvailable? EnterEmailCodeScreen() : Center(child: CircularProgressIndicator()),
      //home: VisitScheduledWorkScreen(),
    );
  }
}

