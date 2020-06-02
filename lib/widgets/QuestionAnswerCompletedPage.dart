import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HelloBeginPage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/QuestionAnswerPage.dart';
import 'package:reditus/widgets/ReportSendPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/TemperatureMeasuringPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'MainPageTestVisit.dart';
import 'WorkLocationPage.dart';

class QuestionAnswerCompletedScreen extends StatefulWidget {

  @override
  _QuestionAnswerCompletedScreenState createState() => _QuestionAnswerCompletedScreenState();
}

class _QuestionAnswerCompletedScreenState extends State<QuestionAnswerCompletedScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      body: loading?Center(child: CircularProgressIndicator(),):Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: widthStep*50,),
                  padding: EdgeInsets.only(top: heightStep*60),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.clear, size: widthStep*50,),
                  padding: EdgeInsets.only(top: heightStep*60),
                  onPressed: (){
                  },
                ),
              ],

            ),
            */

            PaddingBox(
              heightValue: 40,
            ),
            ImageHolder (widthValue: 800, heightValue: 400, imagePath: 'Assets/IconsInUse/Finish.png',),
            PaddingBox(
              heightValue: 50,
            ),

            Container(
              width: double.infinity,
              height: heightStep*200,
              padding: EdgeInsets.symmetric(horizontal: widthStep*30),
              child: SubTitleText('Thank you for answering these Questions', 70,),
            ),
            PaddingBox(
              heightValue: 50,
            ),

            GreenButtonRounded(widthValue: 900, heightValue: 100, buttonText: 'Ok', trailIcon: null, actionButton: (){

              if (EmployeeToDo.bookTest) {
                //go to report test screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ReportSendScreen()),
                );
              }
              else if (EmployeeToDo.reportVisit){
                //go to report last visit screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      RecentVisitsDetailsScreen()),
                );
              }
              else {
                //go to MainTestVisit Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      MainScreenTestVisit()),
                );
              }

            }),

          ],
        ),
      ),
    );
  }
}

