import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/TestTakePicturePage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'MainPageTestVisit.dart';

class EnterTestNumberScreen extends StatefulWidget {
  @override
  _EnterTestNumberScreenState createState() => _EnterTestNumberScreenState();
}

class _EnterTestNumberScreenState extends State<EnterTestNumberScreen> {
  TextEditingController controller;

  String testNumber = 'xxxxx';

  bool testCodeResult = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Complete test', 50, (){
        FocusScope.of(context).unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );        }, true,
              (){Navigator.push(context, MaterialPageRoute(builder: (context) => TestTakePictureScreen()),);
      }, Icons.home, 2),
      body: loading?Center(child: CircularProgressIndicator(),) : GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PaddingBox(heightValue: 50,),

                SimpleText(textValue: GetData.myData[10]['wording'][0], sizeValue: 50,),
                PaddingBox(heightValue: 50,),
                Container(
                  width: widthStep * 900,
                  height: heightStep * 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widthStep * 15),
                    border: Border.all(
                      color: Colors.black12,
                      width: widthStep * 5,
                    ),
                  ),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widthStep * 20),
                      child: Container(
                        width: widthStep * 900*0.9,
                        height: heightStep * 90*0.9,
                        child: TextField(
                          controller: controller,
                          cursorColor: Colors.black,
                          onChanged: (val) => testNumber = val,
                          style: TextStyle(fontSize: widthStep * 45),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Test Number',
                            hintStyle: TextStyle(
                                fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                PaddingBox(heightValue: 450,),
                BlueButtonRounded(buttonText: 'Ok', buttonAction: (){
                  setState(() {
                    loading = true;
                  });
                  getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/TestCode',
                      '',testNumber).then((value){
                    setState(() {
                      loading = false;
                    });
                    testCodeResult = value;
                    if (testCodeResult) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TestTakePictureScreen()),);
                    }
                    else {
                      Alert(
                          context: context,
                          title: "Code Incorrect",
                          closeFunction: (){FocusScope.of(context).unfocus();
                          setState(() {
                            loading = false;
                          });},
                          content: Column(
                            children: <Widget>[
                              PaddingBox(heightValue: 20,),
                              Text('Please check your Test Code again and re-enter', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
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
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
