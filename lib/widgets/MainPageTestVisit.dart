import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/EnterTestNumberPage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:reditus/widgets/WorkLocationPage.dart';

class MainScreenTestVisit extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SubTitleText('Would you like to:', 60),
            ButtonImageHolder(buttonText: GetData.myData[9]['buttons'][0], imagePath: 'Assets/IconsInUse/${GetData.myData[9]['IconNames'][0]}.png', buttonAction: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnterTestNumberScreen()),
              );
            },),
            ButtonImageHolder(buttonText: GetData.myData[9]['buttons'][1], imagePath: 'Assets/IconsInUse/${GetData.myData[9]['IconNames'][1]}.png', buttonAction: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkLocationScreen()),
              );
            },),
          ],
        ),
      )
    );
  }
}
