import 'package:flutter/material.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/LoginPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';

class EnterPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      body: GestureDetector(
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
                  padding: EdgeInsets.only(left: widthStep*30),
                  child: SubTitleText('Please enter your Password', 50),
                ),
                PaddingBox(
                  heightValue: 20,
                ),
                InputTextField(hintIcon: Icons.lock, hintTextValue: 'Password', obscureText: true,),

                PaddingBox(
                  heightValue: 280,
                ),
                BlueButtonRounded(
                  buttonText: 'Ok',
                  buttonAction: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
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
