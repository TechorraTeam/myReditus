import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/MainPageTestVisit.dart';
import 'package:reditus/widgets/QuestionAnswerPage.dart';
import 'package:reditus/widgets/ReportSendPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/WorkLocationPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EmployeeToDo {
  static bool initialQuestionaire;
  static bool dailyQuestionaire;
  static bool bookTest;
  static bool reportVisit;
}

class HelloBeginScreen extends StatefulWidget {
  @override
  _HelloBeginScreenState createState() => _HelloBeginScreenState();
}

class _HelloBeginScreenState extends State<HelloBeginScreen> {
  bool loading = false;
  var data;
  @override
  void initState() {
    loading = true;
    // TODO: implement initState
    super.initState();
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/EmployeeToDo'
        , '', LoginData.myData['userModel']['EmployeeId'].toString()).then((value) {
      EmployeeToDo.dailyQuestionaire = value['mustCompleteDailyQuestionnaire'];
      EmployeeToDo.initialQuestionaire = value['mustCompleteInitialQuestionnaire']; //to be used later
      EmployeeToDo.bookTest = value['mustBookTest'];
      EmployeeToDo.reportVisit = value['mustReportOnVisit'];

      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;

    return Scaffold(
      body: loading?Center(child: CircularProgressIndicator(),) : Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ImageHolder(
                  widthValue: double.infinity,
                  heightValue: 250,
                  imagePath: 'Assets/BGP.png',
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: widthStep*50,),
                  padding: EdgeInsets.only(top: heightStep*60),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],

            ),
            PaddingBox(
              heightValue: 25,
            ),
            ImageHolder(widthValue: 600, heightValue: 350, imagePath: 'Assets/IconsInUse/${GetData.myData[6]['IconNames'][0]}.png',),
            //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
            PaddingBox(
              heightValue: 30,
            ),
            SubTitleText ('Hello ${LoginData.myData['userModel']['FirstName']}', 70),
            PaddingBox(
              heightValue: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthStep*30),
              child: SimpleText(textValue: GetData.myData[6]['wording'][0], sizeValue: 45,),
            ),
            PaddingBox(
              heightValue: 50,
            ),

            BlueButtonRounded(
              buttonText: GetData.myData[6]['buttons'][0],
              buttonAction: (){
                //LoginData.myData['tokenID'], LoginData.myData['userModel']['EmployeeId'].toString()


                if(EmployeeToDo.dailyQuestionaire)
                {
                  setState(() {
                    loading = true;
                  });
                  //load questionnaire for daily
                  getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Questionnaire',
                      '',LoginData.myData['userModel']['EmployeeId'].toString()
                  )
                      .then((val){
                    data = val;
                    if (data != null) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            QuestionAnswerScreen(myData: data,)),
                      );
                    }
                    else {
                      Alert(
                          context: context,
                          title: "Error Data",
                          closeFunction: (){Navigator.pop(context);FocusScope.of(context).unfocus();
                          setState(() {
                            loading = false;
                          });},
                          content: Column(
                            children: <Widget>[
                              PaddingBox(heightValue: 20,),
                              Text('Please check your Internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                              PaddingBox(heightValue: 50,),
                              BlueButtonRounded(buttonText: 'Close', buttonAction: (){Navigator.pop(context);
                              setState(() {
                                loading = false;
                              });
                              },),
                            ],
                          ),
                          buttons: [
                            DialogButton(width: 0, height: 0,
                              child: null,),
                          ]
                      ).show();

                    }
                  });
                }
                else if (EmployeeToDo.bookTest) {
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
              },
            ),

          ],
        ),
      ),
    );
  }
}
