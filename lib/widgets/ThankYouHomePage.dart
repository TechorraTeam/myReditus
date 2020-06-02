import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/EnterEmailCodePage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';


class ThankYouHomeScreen extends StatelessWidget {
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
              heightValue: 20,
            ),
            TitleImage(),
            //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
            PaddingBox(
              heightValue: 20,
            ),

            Container(
                height: heightStep*400,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: widthStep*30),
                child:
                Column(
                  children: <Widget>[
                    SimpleText(textValue: GetData.myData[1]['wording'][0], sizeValue: 45,),
                    PaddingBox(heightValue: 30,),
                    SimpleText(textValue: GetData.myData[1]['wording'][1], sizeValue: 45,),
                  ],
                )
            ),
            PaddingBox(
              heightValue: 20,
            ),
            BlueButtonRounded(
              buttonText: GetData.myData[1]['buttons'][0],
              buttonAction: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnterEmailCodeScreen()),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
