import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HelloBeginPage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/ReportSendPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/WorkLocationPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

TextEditingController emailCon;
TextEditingController passwordCon;
String emailValue = '';
String passwordValue = '';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
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
                  heightValue: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: widthStep*50),
                  child: SimpleText(textValue: 'Please Enter your work email address and the password you have been sent by your employer', sizeValue: 43,),
                ),
                PaddingBox(
                  heightValue: 40,
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
                          child: TextField(
                            controller: emailCon,
                            onChanged: (val){
                              emailValue = val;
                            },
                            cursorColor: Colors.black,
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
                //InputTextDetailedField(hintTextValue: '**********', hintIcon: Icons.lock, labelTextValue: 'Password', obscureText: true,),
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
                        Icon(Icons.lock, color: Colors.blue.shade400,),
                        Container (
                          width: widthStep * 5,
                          height: heightStep * 90,
                          color: Colors.black12,
                        ),
                        Container(
                          width: widthStep * 900*0.80,
                          height: heightStep * 90*0.9,
                          child: TextField(
                            controller: passwordCon,
                            onChanged: (val){
                              passwordValue = val;
                            },
                            cursorColor: Colors.black,
                            obscureText: false,
                            style: TextStyle(fontSize: widthStep * 45),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(widthStep*10),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                              border: InputBorder.none,
                              hintText: '**********',
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
                  heightValue: 1,
                ),
                //!credentialStatus && credentialsEntered? Text('Invalid or empty credentials') : credentialsEntered&& credentialStatus?Text('Valid'):Container(),
                PaddingBox(
                  heightValue: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text('Forgot Password?', style: TextStyle(color: Colors.blue, fontSize: widthStep*30),),
                    onPressed: (){
                      Alert(
                          context: context,
                          title: "Forgot Password?",
                          closeFunction: (){Navigator.pop(context);},
                          content: Column(
                            children: <Widget>[
                              PaddingBox(heightValue: 20,),
                              InputTextField(textSizeValue: 40,),
                              PaddingBox(heightValue: 20,),
                              Text('Please Enter your Email ID', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                              PaddingBox(heightValue: 50,),
                              BlueButtonRounded(buttonText: 'Send', buttonAction: (){},),
                            ],
                          ),
                        buttons: [
                          DialogButton(width: 0, height: 0,
                          child: null,),
                        ]
                          ).show();
                    },
                  ),
                ),
                PaddingBox(
                  heightValue: 35,
                ),
                BlueButtonRounded(
                  buttonText: 'Login',
                  buttonAction: () {
                    print(emailValue);
                    setState(() {
                      loading = true;
                    });
                    login(emailValue, passwordValue)
                    .then((val){
                      setState(() {
                        loading = false;
                      });
                      if (val) {
                        print(LoginData.myData);
                        if (LoginData.myData['userModel']['UserName'] == emailValue)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelloBeginScreen()),
                        );
                      }
                      else{
                        Alert(
                            context: context,
                            title: "Unable to Login",
                            closeFunction: (){FocusScope.of(context).unfocus();},
                            content: Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                Text('Either password or email is wrong, check again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
                                PaddingBox(heightValue: 50,),
                                BlueButtonRounded(buttonText: 'Close', buttonAction: (){Navigator.pop(context);
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
