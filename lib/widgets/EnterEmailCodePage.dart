import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/EnterPasswordPage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/LoginPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/WorkLocationPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'HelloBeginPage.dart';

class EnterEmailCodeScreen extends StatefulWidget {
  @override
  _EnterEmailCodeScreenState createState() => _EnterEmailCodeScreenState();
}

class _EnterEmailCodeScreenState extends State<EnterEmailCodeScreen> {
  String emailValue = '';
  String passwordValue = '1111';
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      body: loading?Center(child: CircularProgressIndicator(),):GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
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
                  heightValue: 5,
                ),
                TitleImage(),
                //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
                PaddingBox(
                  heightValue: 20,
                ),
                SubTitleText(GetData.myData[2]['wording'][0], 50),
                PaddingBox(
                  heightValue: 20,
                ),
                Container(
                  width: widthStep * 900,
                  height: heightStep * 90,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: widthStep*5,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthStep * 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.email, color: Colors.blue.shade400,),
                        Container (
                          width: widthStep * 5,
                          height: heightStep * 90,
                          color: Colors.black12,
                        ),
                        Container(
                          width: widthStep * 900*0.80,
                          height: heightStep * 90*0.9,
                          child: TextFormField(
                            onChanged: (val){
                              emailValue = val;
                            },
                            cursorColor: Colors.black,
                            initialValue: emailValue,
                            obscureText: false,
                            style: TextStyle(fontSize: widthStep * 45),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(widthStep*10),
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                  fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                              border: InputBorder.none,
                              hintText: 'John@email.com',
                              hintStyle: TextStyle(
                                  fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PaddingBox(
                  heightValue: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthStep*60),
                  child: SimpleText(textValue: GetData.myData[2]['wording'][1], sizeValue: 45,),
                ),
                PaddingBox(
                  heightValue: 20,
                ),
                PinCodeTextField(
                  length: 4,
                  shape: PinCodeFieldShape.box,
                  autoDisposeControllers: false,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  inactiveColor: Colors.black12,
                  textInputType: TextInputType.text,
                  onChanged: (value){
                    passwordValue = value;
                  },

                ),
                PaddingBox(
                  heightValue: 20,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: heightStep*30,
                  child: FlatButton(
                    child: Text('Send a new code', style: TextStyle(color: Colors.blue, fontSize: widthStep*30),),
                    onPressed: (){
                      setState(() {
                        loading = true;
                      });
                      Map<String, String> body = {
                        "emailAddress": emailValue
                      };

                      postData('https://reditus.azurewebsites.net/api/Auth/CodeReset', '', '', body).
                      then((value){
                        setState(() {
                          loading = false;
                        });
                        if(value){
                          Alert(
                              context: context,
                              title: "Success!",
                              closeFunction: (){Navigator.pop(context);},
                              content: Column(
                                children: <Widget>[
                                  PaddingBox(heightValue: 20,),
                                  Text('A new code has been generated', style: TextStyle(color: Colors.blue, fontSize: widthStep*35),),
                                  PaddingBox(heightValue: 50,),
                                  GreenButtonRounded(buttonText: 'Okay', trailIcon: null, actionButton:(){Navigator.pop(context);},),
                                ],
                              ),
                              buttons: [
                                DialogButton(width: 0, height: 0,
                                  child: null,),
                              ]
                          ).show();
                        }else{
                          Alert(
                              context: context,
                              title: "Error! Wrong Credentials",
                              closeFunction: (){Navigator.pop(context);},
                              content: Column(
                                children: <Widget>[
                                  PaddingBox(heightValue: 20,),
                                  Text('Please check your email and retry', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                  PaddingBox(heightValue: 50,),
                                  GreenButtonRounded(buttonText: 'Okay', trailIcon: null, actionButton: (){Navigator.pop(context);},),
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
                ),
                PaddingBox(
                  heightValue: 30,
                ),
                BlueButtonRounded(
                  buttonText: GetData.myData[2]['buttons'][0],
                  buttonAction: (){

                    if (EmailValidator.validate(emailValue)){
                      setState(() {
                        loading = true;
                      });
                      login(emailValue, passwordValue)
                          .then((val){
                        setState(() {
                          loading = false;
                        });
                        if (val) {
                          Navigator.push(
                            context,
                            //MaterialPageRoute(builder: (context) => VisitScheduledWorkScreen()),
                            MaterialPageRoute(builder: (context) => HelloBeginScreen()),
                          );
                        }
                        else{
                          Alert(
                              context: context,
                              title: "Unable to Login",
                              closeFunction: (){Navigator.pop(context);},
                              content: Column(
                                children: <Widget>[
                                  PaddingBox(heightValue: 20,),
                                  Text('Either email or code is incorrect, please check again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                  PaddingBox(heightValue: 50,),
                                  GreenButtonRounded(buttonText: 'Close', trailIcon: null, actionButton: (){Navigator.pop(context);
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
                    }else{
                      Alert(
                          context: context,
                          title: "Unable to Login",
                          closeFunction: (){Navigator.pop(context);},
                          content: Column(
                            children: <Widget>[
                              PaddingBox(heightValue: 20,),
                              Text('Either email or code is incorrect, please check again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                              PaddingBox(heightValue: 50,),
                              GreenButtonRounded(buttonText: 'Close', trailIcon: null, actionButton: (){Navigator.pop(context);
                              },),
                            ],
                          ),
                          buttons: [
                            DialogButton(width: 0, height: 0,
                              child: null,),
                          ]
                      ).show();
                    }

                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
