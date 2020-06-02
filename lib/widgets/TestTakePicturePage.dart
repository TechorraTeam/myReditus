import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/MainPageTestVisit.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

class TestTakePictureScreen extends StatefulWidget {
  String testCode;

  TestTakePictureScreen({this.testCode});
  @override
  _TestTakePictureScreenState createState() => _TestTakePictureScreenState();
}

class _TestTakePictureScreenState extends State<TestTakePictureScreen> {
  bool loading = false;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Complete test', 50, () {Navigator.pop(context);}, true, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading?Center(child: CircularProgressIndicator(),):GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PaddingBox(
                  heightValue: 30,
                ),
                Container(
                    width: widthStep*900,
                    height: heightStep*250,
                    child: SimpleText(
                  textValue:
                      GetData.myData[11]['wording'][0]+' '+ GetData.myData[11]['wording'][1],
                  sizeValue: 50,
                )),
                PaddingBox(
                  heightValue: 30,
                ),
                RedButtonRounded(
                  buttonText: GetData.myData[11]['buttons'][0],
                  leadIcon: Icons.add_box,
                  trailIcon: null,
                  actionButton: () async {
                    setState(() {
                      loading = true;
                    });
                    Map<String, dynamic> body = {
                      "id": 0,
                      "employeeId": LoginData.myData['userModel']['EmployeeId'].toString(),
                      "employeeVerifiedOn": "2020-05-16T21:10:20.527Z",
                      "sendOutOn": DateTime.now().toString(),
                      "takenOn": DateTime.now().toString(),
                      "result": "positive",
                      "fileGuid": "",
                      "testCode": widget.testCode,
                    };

                    postData('https://reditus.azurewebsites.net/api/MobileApplication/Test', '', LoginData.myData['userModel']['EmployeeId'].toString(), body).
                    then((value){
                      setState(() {
                        loading = false;
                      });
                      if(value){
                        //navigate to the main menu test visit screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
                        );
                      }
                      else{
                        //show a dialogue box that data has not been sent, try again.
                        Alert(
                            context: context,
                            title: "Response not sent",
                            closeFunction: (){Navigator.pop(context);},
                            content: Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                Text('Check your internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                PaddingBox(heightValue: 50,),
                                BlueButtonRounded(buttonText: 'Ok', buttonAction: (){Navigator.pop(context);},),
                              ],
                            ),
                            buttons: [
                              DialogButton(width: 0, height: 0,
                                child: null,),
                            ]
                        ).show();

                      }
                    });

                    },
                ),
                PaddingBox(
                  heightValue: 30,
                ),
                GreenButtonRounded(
                  buttonText: GetData.myData[11]['buttons'][1],
                  leadIcon: Icons.indeterminate_check_box,
                  trailIcon: null,
                  actionButton: () async {
                    setState(() {
                      loading = true;
                    });
                    Map<String, dynamic> body = {
                      "id": 0,
                      "employeeId": LoginData.myData['userModel']['EmployeeId'].toString(),
                      "employeeVerifiedOn": "2020-05-16T21:10:20.527Z",
                      "sendOutOn": DateTime.now().toString(),
                      "takenOn": DateTime.now().toString(),
                      "result": "negative",
                      "fileGuid": "",
                      "testCode": widget.testCode
                    };

                    postData('https://reditus.azurewebsites.net/api/MobileApplication/Test', '', LoginData.myData['userModel']['EmployeeId'].toString(), body).
                    then((value){
                      setState(() {
                        loading = false;
                      });
                      if(value){
                        //navigate to the main menu test visit screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
                        );
                      }
                      else{
                        //show a dialogue box that data has not been sent, try again.
                        Alert(
                            context: context,
                            title: "Response not sent",
                            closeFunction: (){Navigator.pop(context);},
                            content: Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                Text('Check your internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                PaddingBox(heightValue: 50,),
                                BlueButtonRounded(buttonText: 'Ok', buttonAction: (){Navigator.pop(context);},),
                              ],
                            ),
                            buttons: [
                              DialogButton(width: 0, height: 0,
                                child: null,),
                            ]
                        ).show();

                      }
                    });

                  },
                ),
                PaddingBox(
                  heightValue: 30,
                ),
                Container(
                    width: widthStep*900,
                    child: SimpleText(
                      textValue:
                      GetData.myData[11]['buttons'][2],
                      sizeValue: 50,
                    )),
                GestureDetector(
                    onTap: () async {
                      getImage();
                    },
                    child: ImageHolder(widthValue: 600, heightValue: 270, imagePath: 'Assets/IconsInUse/Camera.png')
                ),
                Container(
                  child: _image == null? Text('No Image'):Image.file(_image),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
