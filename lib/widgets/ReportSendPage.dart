import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/EnterAddressPage.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/MainPageTestVisit.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:search_map_place/search_map_place.dart';

import 'HelloBeginPage.dart';
import 'WorkLocationPage.dart';

class ReportSendScreen extends StatefulWidget {
  @override
  _ReportSendScreenState createState() => _ReportSendScreenState();
}

class _ReportSendScreenState extends State<ReportSendScreen> {
  var data;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
    });

    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Address',
        '',LoginData.myData['userModel']['EmployeeId'].toString())
        .then((value){
          data = value;
          setState(() {
            loading = false;
          });

          if (data == null || data == [])
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnterAddressScreen()),
              );
            }
    });
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
                ImageHolderGradient(textValue: 'Report Send', imagePath: 'Assets/IconsInUse/${GetData.myData[7]['IconNames'][0]}.png',),
                //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
                PaddingBox(
                  heightValue: 50,
                ),

                Container(
                  width: double.infinity,
                  height: heightStep*120,
                  padding: EdgeInsets.symmetric(horizontal: widthStep*30),
                  child: SimpleText(textValue: GetData.myData[7]['wording'][0]+ ' ' +GetData.myData[7]['wording'][1], sizeValue: 50,),
                ),
                PaddingBox(
                  heightValue: 10,
                ),
                //InputTextLocationField(),
                /*
                SearchMapPlaceWidget(
                  apiKey: 'AIzaSyDV87cNktXWY8n3jbltsGrD8q7cBFKXn8k',
                  language: 'en',
                  placeholder: data == null? 'Search':(data['numberStreet']+', '+ data['district']+', '+data['townCity']+', '+data['state']+', '+data['zipCode']),
                ),
                */
                Container(
                  child: SimpleText(sizeValue: 40,textValue: data == null? 'No Address Available':data['singleStringAddress']),
                  width: widthStep*850,
                  height: heightStep*130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 245, 255, 1),
                      borderRadius: BorderRadius.circular(widthStep*20)
                  ),

                ),
                PaddingBox(
                  heightValue: 30,
                ),

                BlueButtonRounded(buttonText: 'Ok', buttonAction: (){
                  if (EmployeeToDo.reportVisit){
                    //go to report last visit screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          RecentVisitsDetailsScreen()),
                    );
                  }
                  else {
                    //go to MainTestVisit Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          MainScreenTestVisit()),
                    );
                  }

                },),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
