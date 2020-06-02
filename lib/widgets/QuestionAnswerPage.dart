import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/QuestionAnswerCompletedPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/TemperatureMeasuringPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String dropDownValue = 'Select the best option';
List<dynamic> allItems = List<dynamic>();

class QuestionAnswerScreen extends StatefulWidget {
  int index = 0;
  bool dataSent = false;
  bool loading = false;
  Map <String, dynamic> questionBody;
  List<Map<String, dynamic>> responses = [];
  final myData;
  QuestionAnswerScreen({
    this.myData
  });

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}
class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  Future<bool> sendData(){
    setState(() {
      widget.loading = true;
    });
    widget.questionBody = {
      "questionnaireId": widget.myData['questionnaireNumber'],
      "employeeId": LoginData.myData['userModel']['EmployeeId'],
      "responses": widget.responses
    };
    putData('https://reditus.azurewebsites.net/api/MobileApplication/Questionnaire',
        '', LoginData.myData['userModel']['EmployeeId'].toString(), widget.questionBody)
        .then((value) {
      setState(() {
        widget.loading = false;
      });
      return value;
    });
  }

  void resetAll() {
    dropDownValue = 'Select the best option';
    allItems = [];
    allItems.add(dropDownValue);
    allItems.addAll(widget.myData['questions'][widget.index]['answerFilters'][0]['answer']);
  }
  @override
  void initState() {
    setState(() {
      widget.loading = true;
    });
    widget.questionBody = {
      "questionnaireId": widget.myData['questionnaireNumber'],
      "employeeId": LoginData.myData['userModel']['EmployeeId'],
      "responses": [{
        "questionId": (widget.index+1),
        "answer": 'testing',
      }]
    };
    putData('https://reditus.azurewebsites.net/api/MobileApplication/Questionnaire',
        '', LoginData.myData['userModel']['EmployeeId'].toString(), widget.questionBody)
        .then((value) {
      setState(() {
        widget.loading = false;
      });
    });
    // TODO: implement initState
    super.initState();
    resetAll();
  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    print(widget.myData['questions'][widget.index]['answerFilters'][0]['answer'].length);
    print(allItems);

    return Scaffold(
      body:
          widget.loading? Center(child: CircularProgressIndicator(),) :
          widget.myData['questions'][widget.index]['answerFilters'][0]['answer'].length > 2 ?
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: widthStep*50,),
                  padding: EdgeInsets.only(top: heightStep*60),
                  onPressed: (){
                    //pop or just subtract the index
                    Navigator.pop(context);
                  },
                ),
                Container(),
              ],

            ),
            PaddingBox(
              heightValue: 25,
            ),
            ImageHolderGradient(textValue: widget.myData['questions'][widget.index]['questionTitle'],
              imagePath: 'Assets/IconsInUse/${widget.myData['questions'][widget.index]['IconName']}.png',),

            //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
            PaddingBox(
              heightValue: 50,
            ),

            Container(
              width: double.infinity,
              height: heightStep*100,
              padding: EdgeInsets.symmetric(horizontal: widthStep*30),
              child: SimpleText(textValue: widget.myData['questions'][widget.index]['questionText'], sizeValue: 50,),
            ),
            PaddingBox(
              heightValue: 10,
            ),

            //DropDown Value

          Container(
          width: widthStep * 600,
          height: heightStep * 80,
          child: DropdownButton<String>(
            elevation: 10,
            value: dropDownValue,
            onChanged: (String newValue) {
              setState(() {
                dropDownValue = newValue;
              });
            },
            //widget.myData['questions'][widget.index]['answerFilters'][0]['answer']
            items: allItems.cast<String>().map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            );
            }).toList(),

          ),

        ),

            PaddingBox(
              heightValue: 100,
            ),
            dropDownValue == 'Select the best option'? Container():
            BlueButtonRounded(buttonText: 'Ok', buttonAction: (){

                if (widget.myData['questions'][widget.index]['answerFilters'][0]['nextQuestion'] != null)
                  setState(() {
                    widget.responses.add(
                        {"questionId": (widget.index+1),
                      "answer": dropDownValue}
                      );
                    widget.index += 1;
                    resetAll();
                  });
                else{
                  Alert(
                      context: context,
                      title: "Error: Data not sent",
                      closeFunction: (){Navigator.pop(context);
                      setState(() {
                        widget.loading = false;
                      });},
                      content: Column(
                        children: <Widget>[
                          PaddingBox(heightValue: 20,),
                          Text('Please check your Internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                          PaddingBox(heightValue: 50,),
                          BlueButtonRounded(buttonText: 'Close', buttonAction: (){Navigator.pop(context);
                          setState(() {
                            widget.loading = false;
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


            },),

          ],
        ),
      )
          :
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
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
                Container(),
              ],

            ),
            PaddingBox(
              heightValue: 25,
            ),
            ImageHolderGradient(textValue: widget.myData['questions'][widget.index]['questionTitle'], imagePath: 'Assets/IconsInUse/${widget.myData['questions'][widget.index]['IconName']}.png',),
            //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
            PaddingBox(
              heightValue: 30,
            ),

            Container(
              width: double.infinity,
              height: heightStep*250,
              padding: EdgeInsets.symmetric(horizontal: widthStep*30),
              child: SimpleText(textValue: widget.myData['questions'][widget.index]['questionText'], sizeValue: 50,),
            ),
            PaddingBox(
              heightValue: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RedButtonRounded(widthValue: 400, heightValue: 80, buttonText: widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][0], trailIcon: null, actionButton: (){

                  if (widget.myData['questions'][widget.index]['answerFilters'][0]['nextQuestion'] != null)
                    setState(() {
                      widget.responses.add({
                        "questionId": (widget.index+1),
                        "answer": widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][0],
                      });
                      widget.index += 1;

                      resetAll();
                    });
                  else{
                    widget.responses.add({
                      "questionId": (widget.index+1),
                      "answer": widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][0],
                    });
                    setState(() {
                      widget.loading = true;
                    });
                    widget.questionBody = {
                      "questionnaireId": widget.myData['questionnaireNumber'],
                      "employeeId": LoginData.myData['userModel']['EmployeeId'],
                      "responses": widget.responses

                      //[{
                      // "questionId": (widget.index+1),
                      //   "answer": widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][1],
                      //}]

                      //widget.responses
                    };
                    putData('https://reditus.azurewebsites.net/api/MobileApplication/Questionnaire',
                        '', LoginData.myData['userModel']['EmployeeId'].toString(), widget.questionBody)
                        .then((value) {
                      print('resonses');
                      print(widget.responses);
                      setState(() {
                        widget.loading = false;
                        if(value){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuestionAnswerCompletedScreen()),
                          );
                        }
                        else{

                          Alert(
                              context: context,
                              title: "Error: Data not sent",
                              closeFunction: (){Navigator.pop(context);
                              setState(() {
                                widget.loading = false;
                              });},
                              content: Column(
                                children: <Widget>[
                                  PaddingBox(heightValue: 20,),
                                  Text('Please check your Internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                  PaddingBox(heightValue: 50,),
                                  BlueButtonRounded(buttonText: 'Close', buttonAction: (){Navigator.pop(context);
                                  setState(() {
                                    widget.loading = false;
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
                    });

                  }

                },),

                GreenButtonRounded(widthValue: 400, heightValue: 80, buttonText: widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][1], trailIcon: null, actionButton: () async {
                  if (widget.myData['questions'][widget.index]['answerFilters'][0]['nextQuestion'] != null)
                    setState(() {
                      widget.responses.add({
                        "questionId": (widget.index+1),
                        "answer": widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][1],
                      });
                      widget.index += 1;

                      resetAll();
                    });
                  else{
                    widget.responses.add({
                      "questionId": (widget.index+1),
                      "answer": widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][1],
                    });
                    setState(() {
                      widget.loading = true;
                    });
                    widget.questionBody = {
                      "questionnaireId": widget.myData['questionnaireNumber'],
                      "employeeId": LoginData.myData['userModel']['EmployeeId'],
                      "responses": widget.responses

                      //[{
                      // "questionId": (widget.index+1),
                       //   "answer": widget.myData['questions'][widget.index]['answerFilters'][0]['answer'][1],
                      //}]

                      //widget.responses
                    };
                    putData('https://reditus.azurewebsites.net/api/MobileApplication/Questionnaire',
                        '', LoginData.myData['userModel']['EmployeeId'].toString(), widget.questionBody)
                        .then((value) {
                      print('resonses');
                      print(widget.responses);
                      setState(() {
                        widget.loading = false;
                        if(value){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuestionAnswerCompletedScreen()),
                          );
                        }
                        else{
                          Alert(
                              context: context,
                              title: "Error: Data not sent",
                              closeFunction: (){Navigator.pop(context);
                              setState(() {
                                widget.loading = false;
                              });},
                              content: Column(
                                children: <Widget>[
                                  PaddingBox(heightValue: 20,),
                                  Text('Please check your Internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                  PaddingBox(heightValue: 50,),
                                  BlueButtonRounded(buttonText: 'Close', buttonAction: (){Navigator.pop(context);
                                  setState(() {
                                    widget.loading = false;
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
                    });

                  }

                }),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


