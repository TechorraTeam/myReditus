import 'package:flutter/material.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/MainPageTestVisit.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:search_map_place/search_map_place.dart';

import 'HelloBeginPage.dart';
import 'WorkLocationPage.dart';

class EnterAddressScreen extends StatefulWidget {
  @override
  _EnterAddressScreenState createState() => _EnterAddressScreenState();
}

class _EnterAddressScreenState extends State<EnterAddressScreen> {
  var data;
  String addressValue = 'Search';
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
                ImageHolderGradient(textValue: 'Enter Address', imagePath: 'Assets/IconsInUse/${GetData.myData[8]['IconNames'][0]}.png',),
                //Text('Thank you!', style: TextStyle(color: Colors.green, fontSize: widthStep*70, fontWeight: FontWeight.w800),),
                PaddingBox(
                  heightValue: 50,
                ),

                Container(
                  width: double.infinity,
                  height: heightStep*70,
                  padding: EdgeInsets.symmetric(horizontal: widthStep*30),
                  child: SimpleText(textValue: GetData.myData[8]['wording'][0], sizeValue: 50,),
                ),
                PaddingBox(
                  heightValue: 10,
                ),
                //InputTextLocationField(),
                SearchMapPlaceWidget(
                  apiKey: 'AIzaSyDV87cNktXWY8n3jbltsGrD8q7cBFKXn8k',
                  language: 'en',
                  onSelected: (value){
                    addressValue = value.description;
                  },
                  placeholder: data == null? addressValue:data['numberStreet']+', '+ data['district']+', '+data['townCity']+', '+data['state']+', '+data['zipCode'],
                ),
                PaddingBox(
                  heightValue: 120,
                ),
                BlueButtonRounded(buttonText: 'Back to Main Menu', buttonAction: (){
                  setState(() {
                    loading = true;
                  });
                  Map<String, dynamic> body = {
                      "id": 0,
                      "deleted": false,
                      "employeeId": LoginData.myData['userModel']['EmployeeId'].toString(),
                      "singleStringAddress": addressValue,
                      "numberStreet": addressValue,
                      "district": addressValue,
                      "townCity": addressValue,
                      "state": addressValue,
                      "zipCode": addressValue
                  };
                  postData('https://reditus.azurewebsites.net/api/MobileApplication/Address',
                      '','', body).then((value){
                        if (value){
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
                        }else{
                          Alert(
                              context: context,
                              title: "Error: Data not sent",
                              closeFunction: (){Navigator.pop(context);
                              setState(() {
                                loading = false;
                              });},
                              content: Column(
                                children: <Widget>[
                                  PaddingBox(heightValue: 20,),
                                  Text('Please check your Internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
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
