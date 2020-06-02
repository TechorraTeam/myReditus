import 'package:flutter/material.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/ReportSendPage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';

class TemperatureMeasuringScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      body: Container(
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
                IconButton(
                  icon: Icon(Icons.clear, size: widthStep*50,),
                  padding: EdgeInsets.only(top: heightStep*60),
                  onPressed: (){
                  },
                ),
              ],

            ),
            PaddingBox(
              heightValue: 25,
            ),
            ImageHolderGradient(textValue: 'Temperature', imagePath: 'Assets/IconsInUse/Temperature.png',),
            //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
            PaddingBox(
              heightValue: 50,
            ),

            Container(
              width: double.infinity,
              height: heightStep*100,
              padding: EdgeInsets.symmetric(horizontal: widthStep*30),
              child: SimpleText(textValue: 'Please take your temperature and enter in the box below:', sizeValue: 50,),
            ),
            PaddingBox(
              heightValue: 10,
            ),

            DropDownButton(),

            PaddingBox(
              heightValue: 100,
            ),
            BlueButtonRounded(buttonText: 'Ok', buttonAction: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportSendScreen()),
              );
            },),

          ],
        ),
      ),
    );
  }
}
