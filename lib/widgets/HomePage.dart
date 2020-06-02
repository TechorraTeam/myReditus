import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/ThankYouHomePage.dart';

double widthStep, heightStep;

class HomeScreen extends StatelessWidget {
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
            ImageHolder(
              widthValue: double.infinity,
              heightValue: 300,
              imagePath: 'Assets/BGP.png',
            ),
            PaddingBox(
              heightValue: 25,
            ),
            TitleImage(),
            SubTitleText(GetData.myData[0]['title'], 50),
            PaddingBox(
              heightValue: 250,
            ),
            BlueButtonRounded(
              buttonText: GetData.myData[0]['buttons'][0],
              buttonAction: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThankYouHomeScreen()),
                );
              },
            ),
            PaddingBox(
              heightValue: 40,
            ),
            Container(
              width: widthStep*800,
              child: SimpleText(
                textValue:
                    GetData.myData[0]['wording'][0],
                sizeValue: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


