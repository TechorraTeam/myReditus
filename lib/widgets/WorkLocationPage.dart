import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:reditus/Services/DataFetchingJson.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:reditus/widgets/MainPageTestVisit.dart';
import 'package:reditus/widgets/ReusableWidgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:search_map_place/search_map_place.dart';

//Work Location Main Page two buttons
class WorkLocationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Work Location', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 100,),
            WhiteButtonCurved(buttonText: GetData.myData[12]['buttons'][0], actionButton: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScheduleWorkLocationScreen()),
              );
            },),
            PaddingBox(heightValue: 70,),
            WhiteButtonCurved(buttonText: GetData.myData[12]['buttons'][1], actionButton: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VisitScheduledWorkScreen()),
              );
            },),

          ],
        ),
      ),
    );
  }
}

//Recent visits
class RecentVisitsDetailsScreen extends StatefulWidget {
  @override
  _RecentVisitsDetailsScreenState createState() => _RecentVisitsDetailsScreenState();
}

class _RecentVisitsDetailsScreenState extends State<RecentVisitsDetailsScreen> {
  var dataLoaded;
  bool loading = false;
  @override
  void initState() {
    loading = true;
    // TODO: implement initState
    super.initState();
    //LoginData.myData['userModel']['EmployeeId'].toString()
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/LastVisit','', LoginData.myData['userModel']['EmployeeId'].toString())
        .then((val){
      setState(() {
        loading = false;
        if(val == null)
          dataLoaded = [];
        else
          dataLoaded = val;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Recent Visits', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading? Center(child: CircularProgressIndicator(),): Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 50,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthStep*40),
              child: SubTitleText('Which Visit would you like to tell us about:', 60),
            ),
            PaddingBox(heightValue: 50,),
            dataLoaded.length < 1?Center(child: Text('NO RECENT VISITS',
              style: TextStyle(fontSize: widthStep*50, color: Colors.red, fontWeight: FontWeight.w600),),)
                :
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext ctxt, int Index) {
                return Column(
                  children: <Widget>[
                    PaddingBox(heightValue: 50,),
                    //DateFormat('MEd').format(DateTime.parse(dataLoaded[Index]['date']))
                    WhiteButtonCurved(buttonText: DateFormat('EEEE, MMMM d, yyyy').
                    format(DateTime.parse(dataLoaded[Index]['date'])),
                    actionButton: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentAreasVisitedScreen(locationId: dataLoaded[Index]['locationId'].toString(),)),
                      );
                    },),
                  ],
                )
                ;
              }, itemCount: dataLoaded.length,),
            ),

          ],
        ),
      ),
    );
  }
}

//Recent Areas Visited
class RecentAreasVisitedScreen extends StatefulWidget {
  String locationId;
  RecentAreasVisitedScreen({this.locationId = '41'});
  @override
  _RecentAreasVisitedScreenState createState() => _RecentAreasVisitedScreenState();
}

class _RecentAreasVisitedScreenState extends State<RecentAreasVisitedScreen> {
  var dataLoaded;
  dynamic allPlaces;
  bool loading = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    //LoginData.myData['userModel']['EmployeeId'].toString() ..... widget.locationId
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/LocationSubzones','', '41')
        .then((val){
      setState(() {
        loading = false;
        dataLoaded = val;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Recent Areas', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
      );}, Icons.home, 2),
      body: loading? Center(child: CircularProgressIndicator(),): Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthStep*40),
              child: SubTitleText('Which areas did you visit:', 60),
            ),
            dataLoaded.length < 1?Center(child: Text('NO RECENT AREAS VISITED',
              style: TextStyle(fontSize: widthStep*50, color: Colors.red, fontWeight: FontWeight.w600),),)
                :
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext ctxt, int Index) {
                return Column(
                  children: <Widget>[
                    PaddingBox(heightValue: 30,),
                    //DateFormat('MEd').format(DateTime.parse(dataLoaded[Index]['date']))
                    WhiteButtonCurved(buttonText: dataLoaded[Index]['subzoneName'],
                      actionButton: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MainScreenTestVisit()),
                        );
                      },),
                  ],
                )
                ;
              }, itemCount: dataLoaded.length,),
            ),

            PaddingBox(heightValue: 30,),
            GreenButtonRounded(widthValue: 900, heightValue: 90, trailIcon: null, buttonText: 'Ok', actionButton: (){},),
            PaddingBox(heightValue: 30,),

          ],
        ),
      ),
    );
  }
}

//Schedule a work location visit
class ScheduleWorkLocationScreen extends StatefulWidget {
  var dataLoaded;
  var dataSegment;
  bool dataAvailable = false;
  @override
  _ScheduleWorkLocationScreenState createState() => _ScheduleWorkLocationScreenState();
}

class _ScheduleWorkLocationScreenState extends State<ScheduleWorkLocationScreen> {
  var sortedDataSegment = [];
  var sortValues = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //LoginData.myData['userModel']['EmployeeId'].toString()
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Locations', '', LoginData.myData['userModel']['EmployeeId'].toString())
        .then((val){
          setState(() {
            widget.dataLoaded = val;
            widget.dataSegment = widget.dataLoaded['item1'];
            sortValues = widget.dataLoaded['item2'];
            for (int i = 0; i < widget.dataSegment.length; i++) {
              if (i < sortValues.length){
                for (int k = 0; k < widget.dataSegment.length; k++) {
                  if (sortValues[i] == widget.dataSegment[k]['id']) {
                    sortedDataSegment.add(widget.dataSegment[k]);
                  }
                }
              }
              else{
                  sortedDataSegment.add(widget.dataSegment[i]);
              }

            }
          });
      if (widget.dataSegment != null) {
        setState(() {
          widget.dataAvailable = true;
        });
      }
      //print(widget.dataSegment[0]['name']);
      //widget.dataLength = widget.dataLoaded['item1'].length as int;
    });
  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Work Location', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: widget.dataAvailable?Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 50,),
            SimpleText(textValue: GetData.myData[13]['wording'][0], sizeValue: 55,),
            PaddingBox(heightValue: 40,),

            widget.dataSegment.length < 1?Center(child: Text('NO LOCATIONS AVAILABLE',
              style: TextStyle(fontSize: widthStep*50, color: Colors.red, fontWeight: FontWeight.w600),),)
                :
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext ctxt, int Index) {
                return Column(
                  children: <Widget>[
                    PaddingBox(heightValue: 10,),
                    WhiteButtonCurved(buttonText: sortedDataSegment[Index]['name'], actionButton: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DaySelectionWorkLocationScreen(locationName: sortedDataSegment[Index]['name'],
                        locationId: sortedDataSegment[Index]['id'].toString(),)),
                      );
                    },),
                    PaddingBox(heightValue: 20,),

                  ],
                )
                ;
              }, itemCount: sortedDataSegment.length,),
            ),
            //WhiteButtonCurved(buttonText: 'API Location 1', actionButton: (){},),
            //WhiteButtonCurved(buttonText: 'API Location 2', actionButton: (){},),


          ],
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

//Time selection for visit
class DaySelectionWorkLocationScreen extends StatefulWidget {
  String locationName;
  String locationId;
  DaySelectionWorkLocationScreen({this.locationName, this.locationId});
  @override
  _DaySelectionWorkLocationScreenState createState() => _DaySelectionWorkLocationScreenState();
}

class _DaySelectionWorkLocationScreenState extends State<DaySelectionWorkLocationScreen> {
  var dataLoaded;
  bool loading = false;
  @override
  void initState() {
    loading = true;
    // TODO: implement initState
    super.initState();
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/PossibleBookingDates', '', '')
        .then((val){
          setState(() {
            loading = false;
            dataLoaded = val;
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Work Location', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading?Center(child: CircularProgressIndicator(),): Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 50,),
            SimpleText(textValue: 'When would you like to visit the office? ${widget.locationName}', sizeValue: 55,),
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext ctxt, int Index) {
                return Column(
                  children: <Widget>[
                    PaddingBox(heightValue: 40,),
                    WhiteButtonCurved(buttonText: dataLoaded[Index]['item2'], actionButton: (){
                      setState(() {
                        loading = true;
                      });
                      Map<String, dynamic> body = {
                        "id": 0,
                        "deleted": false,
                        "locationId": widget.locationId,
                        "employeeId": LoginData.myData['userModel']['EmployeeId'].toString(),
                        "date": dataLoaded[Index]['item1'],
                        "visitType": 0,
                        "visitorBooked": false,
                        "reportedOn": false
                      };

                      postData('https://reditus.azurewebsites.net/api/MobileApplication/Visit', '', '', body).
                      then((value){
                        print (value);
                        setState(() {
                          loading = false;
                        });
                        if (value)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppointmentDoneWorkScreen(
                                locationName: widget.locationName,
                                locationDate: dataLoaded[Index]['item2'],
                                locationDatePost: dataLoaded[Index]['item1'],
                                locationId: widget.locationId,
                              )),
                            );
                          }
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NoVisitWorkScreen()),
                          );
                        }
                      });

                    },),
                  ],
                )
                ;
              }, itemCount: dataLoaded.length,),
            ),
          ],
        ),
      ),
    );
  }
}

//Search For Location
class SearchLocationWorkScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Work Location', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PaddingBox(heightValue: 100,),
                SimpleText(textValue: 'Search for location', sizeValue: 60,),
                PaddingBox(heightValue: 50,),
                SearchMapPlaceWidget(
                  apiKey: 'AIzaSyDV87cNktXWY8n3jbltsGrD8q7cBFKXn8k',
                  language: 'en',
                ),
                //InputTextLocationField(),
                PaddingBox(heightValue: 400,),
                BlueButtonRounded(buttonText: 'Ok', buttonAction: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaySelectionWorkLocationScreen()),
                  );
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Appointment Done
class AppointmentDoneWorkScreen extends StatefulWidget {
  String locationName;
  String locationDate;
  String locationDatePost;
  String locationId;
  AppointmentDoneWorkScreen({this.locationName = 'London', this.locationDate = 'Tomorrow', this.locationId, this.locationDatePost});

  @override
  _AppointmentDoneWorkScreenState createState() => _AppointmentDoneWorkScreenState();
}

class _AppointmentDoneWorkScreenState extends State<AppointmentDoneWorkScreen> {
  bool loading = false;
  String visitId;

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Work Location', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading?Center(child: CircularProgressIndicator(),):Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PaddingBox(heightValue: 50,),
              ImageHolder(widthValue: 700, heightValue: 250, imagePath: 'Assets/IconsInUse/${GetData.myData[16]['IconNames'][1]}.png',),
              PaddingBox(heightValue: 20,),
              SubTitleText('Appointment', 65),
              PaddingBox(heightValue: 10,),
              Container(
                  width: widthStep*850,
                  height: heightStep*170,
                  child: SimpleText (textValue: GetData.myData[16]['wording'][0].toString().replaceAll('LOCATIONNAME', widget.locationName).replaceAll('LOCATIONDATE', widget.locationDate), sizeValue: 45,)),
              PaddingBox(heightValue: 20,),
              Container(
                  width: widthStep*850,
                  height: heightStep*150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 245, 255, 1),
                      borderRadius: BorderRadius.circular(widthStep*20)
                  ),
                  child: SimpleItalicText(textValue: GetData.myData[16]['wording'][1], sizeValue: 40,)
              ),
              PaddingBox(heightValue: 30,),
              BlueButtonRounded(buttonText: GetData.myData[16]['buttons'][0], buttonAction: (){
                setState(() {
                  loading = true;
                });
                getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Visits', '',
                    LoginData.myData['userModel']['EmployeeId'].toString())
                    .then((value){
                      setState(() {
                        loading = false;
                      });
                      if (value != null && value != [])
                        {
                          visitId = value[value.length - 1]['id'].toString();
                          print(visitId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookVisitorScreen(visitId: visitId,)),
                          );
                        }
                      else{
                        Alert(
                            context: context,
                            title: "Error: Data not loaded",
                            closeFunction: (){Navigator.pop(context);
                            setState(() {
                              loading = false;
                            });},
                            content: Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                Text('Please check your internet connection and try again', style: TextStyle(color: Colors.red, fontSize: widthStep*35),),
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
    );
  }
}

//Unable to Visit, no appointment
class NoVisitWorkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Work Location', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 50,),
            ImageHolder(widthValue: 600, heightValue: 250, imagePath: 'Assets/IconsInUse/${GetData.myData[17]['IconNames'][1]}.png',),
            PaddingBox(heightValue: 20,),
            SubTitleText('Unable to Visit', 65),
            PaddingBox(heightValue: 20,),
            Container(
                width: widthStep*850,
                height: heightStep*160,
                child: SimpleText (textValue: GetData.myData[17]['wording'][0], sizeValue: 45,)),
            PaddingBox(heightValue: 20,),
            Container(
                width: widthStep*850,
                height: heightStep*150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 255, 1),
                    borderRadius: BorderRadius.circular(widthStep*20)
                ),
                child: SimpleItalicText(textValue: GetData.myData[17]['wording'][1], sizeValue: 40,)
            ),
            PaddingBox(heightValue: 30,),
            BlueButtonRounded(buttonText: GetData.myData[17]['buttons'][0], buttonAction: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VisitScheduledWorkScreen()),
              );
            },),
          ],
        ),
      ),
    );
  }
}

//Visit Schedule
class VisitScheduledWorkScreen extends StatefulWidget {
  @override
  _VisitScheduledWorkScreenState createState() => _VisitScheduledWorkScreenState();
}

class _VisitScheduledWorkScreenState extends State<VisitScheduledWorkScreen> {
    var dataLoaded =[];
    bool loading = false;
    @override
    void initState() {
      loading = true;
      // TODO: implement initState
      super.initState();
      //LoginData.myData['userModel']['EmployeeId'].toString()
      getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Visits','', LoginData.myData['userModel']['EmployeeId'].toString())
          .then((val){
        setState(() {
          loading = false;
          dataLoaded = val;
        });
      });
    }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Scheduled Visits', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading?Center(child: CircularProgressIndicator(),):Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthStep*40),
              child: SimpleText(textValue: GetData.myData[18]['wording'][0], sizeValue: 55,),
            ),
            PaddingBox(heightValue: 40,),

            dataLoaded.length < 1?Center(child: Text('NO VISITS BOOKED YET',
              style: TextStyle(fontSize: widthStep*50, color: Colors.red, fontWeight: FontWeight.w600),),)
                :
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext ctxt, int Index) {
                return Column(
                  children: <Widget>[
                    PaddingBox(heightValue: 10,),
                    WhiteButtonCurved(buttonText: DateFormat('EEEE, MMMM d, yyyy').
                    format(DateTime.parse(dataLoaded[Index]['date'])),
                      actionButton: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScheduledVisitConfirmedScreen(dataLoaded[Index])),
                      );
                    },),
                    PaddingBox(heightValue: 20,),
                  ],
                )
                ;
              }, itemCount: dataLoaded.length,),
            ),

          ],
        ),
      ),
    );
  }
}

//scheduled visit confirmation
class ScheduledVisitConfirmedScreen extends StatefulWidget {
  var dataLoaded;
  ScheduledVisitConfirmedScreen(this.dataLoaded);
  @override
  _ScheduledVisitConfirmedScreenState createState() => _ScheduledVisitConfirmedScreenState();
}

class _ScheduledVisitConfirmedScreenState extends State<ScheduledVisitConfirmedScreen> {
  bool loading = false;
  String visitId;
 String locationName = '';

  @override
  void initState() {
    loading = true;
    visitId = widget.dataLoaded['id'].toString();
    print(visitId + ' ye hai visit id');
    //loading = true;
    // TODO: implement initState
    super.initState();
    print(widget.dataLoaded['date']);
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Locations', '', LoginData.myData['userModel']['EmployeeId'].toString()).
    then((value){
      //print(value);
      if(value != null){
        print(value['item1'].length);
        for (int i = 0; i < value['item1'].length; i++)
          if (value['item1'][i]['id'] == widget.dataLoaded['locationId'])
            locationName = value['item1'][i]['name'];
      }
      print(locationName);
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
      appBar: myAppBar('Scheduled Visits', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading?Center(child: CircularProgressIndicator(),):Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 50,),
            ImageHolder(widthValue: 600, heightValue: 250, imagePath: 'Assets/IconsInUse/Appointment.png',),
            PaddingBox(heightValue: 30,),
            Container(
                width: widthStep*850,
                height: heightStep*200,
                child: SimpleText (textValue: GetData.myData[19]['wording'][0].toString().replaceAll('LOCATIONNAME', "'"+locationName+"'").replaceAll('LOCATIONDATE', "'"+DateFormat('EEEE, MMMM d, yyyy').
                format(DateTime.parse(widget.dataLoaded['date']))+"'"), sizeValue: 50,)),
            PaddingBox(heightValue: 60,),
            RedButtonRounded(buttonText: GetData.myData[19]['buttons'][0], actionButton: (){
              Alert(
                  context: context,
                  title: "Confirm Cancel Visit?",
                  closeFunction: (){Navigator.pop(context);
                  },
                  content: Column(
                    children: <Widget>[
                      PaddingBox(heightValue: 20,),
                      Text('Do you really want to cancel this visit?', style: TextStyle(color: Colors.blue, fontSize: widthStep*35),),
                      PaddingBox(heightValue: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GreenButtonRounded(widthValue: 250, heightValue: 70, trailIcon: null, buttonText: 'YES', actionButton: (){
                            Navigator.pop(context);
                            setState(() {
                              loading = true;
                            });
                            deleteData('https://reditus.azurewebsites.net/api/MobileApplication/Visit', '', visitId).then((value){
                              setState(() {
                                loading = false;
                              });
                              print(value);
                              if(value)
                                Alert(
                                    context: context,
                                    title: "SUCCESS!",
                                    closeFunction: (){Navigator.pop(context); Navigator.pop(context); Navigator.pop(context);
                                    setState(() {
                                      loading = false;
                                    });},
                                    content: Column(
                                      children: <Widget>[
                                        PaddingBox(heightValue: 20,),
                                        Text('Visit Canceled', style: TextStyle(color: Colors.green, fontSize: widthStep*45),),
                                        PaddingBox(heightValue: 50,),
                                        BlueButtonRounded(buttonText: 'Close', buttonAction: (){Navigator.pop(context); Navigator.pop(context); Navigator.pop(context);
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
                              else
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
                            });
                          },),
                          RedButtonRounded(widthValue: 250, heightValue: 70, trailIcon: null, buttonText: 'NO', actionButton: (){
                            Navigator.pop(context);
                            
                          },),
                        ],
                      ),

                    ],
                  ),
                  buttons: [
                    DialogButton(width: 0, height: 0,
                      child: null,),
                  ]
              ).show();
              
            },),
            PaddingBox(heightValue: 60,),
            GreenButtonRounded(buttonText: GetData.myData[19]['buttons'][1], actionButton: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageVisitorsScreen(visitId: visitId,)),
              );
            },),
          ],
        ),
      ),
    );
  }
}

//Manage visitors
class ManageVisitorsScreen extends StatelessWidget {
  String visitId;
  ManageVisitorsScreen({this.visitId});
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Manage Visitors', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 50,),
            ImageHolder(widthValue: 800, heightValue: 400, imagePath: 'Assets/IconsInUse/Visitor.png',),

            PaddingBox(heightValue: 130,),
            RedButtonRounded(buttonText: 'Add new Visitors', actionButton: (){
              print(visitId);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookVisitorScreen(visitId: visitId,)),
              );
            },),
            PaddingBox(heightValue: 50,),
            GreenButtonRounded(buttonText: 'Manage Visitors', actionButton: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CancelVisitorsScreen(visitId: visitId,)),
              );
            },),
          ],
        ),
      ),
    );
  }
}

//Cancel Visitors Manage
class CancelVisitorsScreen extends StatefulWidget {
  String visitId;
  CancelVisitorsScreen({this.visitId});
  @override
  _CancelVisitorsScreenState createState() => _CancelVisitorsScreenState();
}

class _CancelVisitorsScreenState extends State<CancelVisitorsScreen> {
  bool loading = false;
  var dataLoaded = [];
  @override
  void initState() {
      loading = true;
    // TODO: implement initState
    super.initState();
    getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Visitors', '', widget.visitId).then((value){
      setState(() {
        loading = false;
      });
      if (value != null)
        dataLoaded = value;
      else
        dataLoaded = [];
    });
  }
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Manage Visitors - Cancel', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading ? Center(child: CircularProgressIndicator(),) : Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            PaddingBox(heightValue: 10,),
            ImageHolder(widthValue: 800, heightValue: 350, imagePath: 'Assets/IconsInUse/Visitor.png',),
            PaddingBox(heightValue: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthStep*60),
              child: SimpleText(textValue: 'Click on a visitor to cancel them from the visit booking', sizeValue: 50,),
            ),
            PaddingBox(heightValue: 20,),

            dataLoaded.length < 1?Center(child: Text('NO VISITORS BOOKED YET',
              style: TextStyle(fontSize: widthStep*50, color: Colors.red, fontWeight: FontWeight.w600),),)
                :
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext ctxt, int Index) {
                return Column(
                  children: <Widget>[
                    PaddingBox(heightValue: 10,),
                    GreenButtonRounded(widthValue: 800, buttonText: dataLoaded[Index], trailIcon: null, actionButton: (){
                      //Alert dialog here to confirm if you want to delete
                      print(widget.visitId);
                      print(dataLoaded[Index]);
                      Alert(
                          context: context,
                          title: "Confirm Cancel Visitor?",
                          closeFunction: (){Navigator.pop(context);
                          },
                          content: Column(
                            children: <Widget>[
                              PaddingBox(heightValue: 20,),
                              Text('Do you really want to cancel this visitor? '+dataLoaded[Index], style: TextStyle(color: Colors.blue, fontSize: widthStep*35),),
                              PaddingBox(heightValue: 50,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GreenButtonRounded(widthValue: 250, heightValue: 70, trailIcon: null, buttonText: 'YES', actionButton: (){
                                    Navigator.pop(context);
                                    setState(() {
                                      loading = true;
                                    });
                                    deleteData('https://reditus.azurewebsites.net/api/MobileApplication/Visitor', '', widget.visitId+'/'+dataLoaded[Index]).then((value){
                                      setState(() {
                                        loading = false;
                                      });
                                      if(value)
                                        Alert(
                                            context: context,
                                            title: "Success!",
                                            closeFunction: (){
                                              setState(() {
                                                loading = true;
                                              });
                                              Navigator.pop(context);
                                              getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Visitors', '', widget.visitId).then((value){
                                                setState(() {
                                                  loading = false;
                                                });
                                                if (value != null)
                                                  dataLoaded = value;
                                                else
                                                  dataLoaded = [];
                                              });
                                            },
                                            content: Column(
                                              children: <Widget>[
                                                PaddingBox(heightValue: 20,),
                                                Text('Visitor Deleted', style: TextStyle(color: Colors.green, fontSize: widthStep*45),),
                                                PaddingBox(heightValue: 50,),
                                                BlueButtonRounded(buttonText: 'Close', buttonAction: (){
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  Navigator.pop(context);
                                                getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Visitors', '', widget.visitId).then((value){
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  if (value != null)
                                                    dataLoaded = value;
                                                  else
                                                    dataLoaded = [];
                                                });
                                                },),
                                              ],
                                            ),
                                            buttons: [
                                              DialogButton(width: 0, height: 0,
                                                child: null,),
                                            ]
                                        ).show();
                                      else
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

                                    });
                                  },),
                                  RedButtonRounded(widthValue: 250, heightValue: 70, trailIcon: null, buttonText: 'NO', actionButton: (){
                                    Navigator.pop(context);

                                  },),
                                ],
                              ),

                            ],
                          ),
                          buttons: [
                            DialogButton(width: 0, height: 0,
                              child: null,),
                          ]
                      ).show();
                    },),
                    PaddingBox(heightValue: 10,),
                  ],
                )
                ;
              }, itemCount: dataLoaded.length,),
            ),
        ],
        ),
      ),
    );
  }
}

//Book a visitor
class BookVisitorScreen extends StatefulWidget {
  String visitId;

  BookVisitorScreen({this.visitId});
  @override
  _BookVisitorScreenState createState() => _BookVisitorScreenState();
}

class _BookVisitorScreenState extends State<BookVisitorScreen> {
  bool loading = false;
  String emailValue = '';
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      appBar: myAppBar('Book a Visitor', 50, (){Navigator.pop(context);}, true, (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreenTestVisit()),
        );
      }, Icons.home, 2),
      body: loading? Center(child: CircularProgressIndicator(),) : GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PaddingBox(heightValue: 50,),
                ImageHolder(widthValue: 600, heightValue: 250, imagePath: 'Assets/IconsInUse/Appointment.png',),
                PaddingBox(heightValue: 30,),
                Container(
                    width: widthStep*850,
                    height: heightStep*150,
                    child: SimpleText (textValue: GetData.myData[20]['wording'][0]+' '+GetData.myData[20]['wording'][1], sizeValue: 50,)),
                PaddingBox(heightValue: 20,),

                Container(
                  width: widthStep * 800,
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
                          cursorColor: Colors.black,
                          onChanged: (val) => emailValue = val,
                          style: TextStyle(fontSize: widthStep * 45),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Email Address',
                            hintStyle: TextStyle(
                                fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                PaddingBox(heightValue: 150,),
                BlueButtonRounded(buttonText: 'Ok', buttonAction: (){

                  if(EmailValidator.validate(emailValue)) {
                    print(widget.visitId);
                    print(emailValue);
                    setState(() {
                      loading = true;
                    });
                    putData(
                        'https://reditus.azurewebsites.net/api/MobileApplication/Visitor',
                        '', widget.visitId + '/' + emailValue, {})
                        .then((value) {
                      if (value) {
                        Alert(
                            context: context,
                            title: "Success!",
                            closeFunction: () {
                              Navigator.pop(context);
                              setState(() {
                                loading = false;
                              });
                            },
                            content: Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                Text(
                                  'Visitor has been registered, now navigate to the main screen',
                                  style: TextStyle(color: Colors.green,
                                      fontSize: widthStep * 35),),
                                PaddingBox(heightValue: 50,),
                                BlueButtonRounded(
                                  buttonText: 'Ok', buttonAction: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);

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
                      else {
                        Alert(
                            context: context,
                            title: "Error: Data not sent",
                            closeFunction: () {
                              Navigator.pop(context);
                              setState(() {
                                loading = false;
                              });
                            },
                            content: Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                Text(
                                  'Please check your Internet connection and try again',
                                  style: TextStyle(color: Colors.red,
                                      fontSize: widthStep * 35),),
                                PaddingBox(heightValue: 50,),
                                BlueButtonRounded(
                                  buttonText: 'Close', buttonAction: () {
                                  Navigator.pop(context);
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
                  }
                  else
                    {
                      Alert(
                          context: context,
                          title: "Invalid Email",
                          closeFunction: () {
                            Navigator.pop(context);
                            setState(() {
                              loading = false;
                            });
                          },
                          content: Column(
                            children: <Widget>[
                              PaddingBox(heightValue: 20,),
                              Text(
                                'The Email that you have entered is not valid',
                                style: TextStyle(color: Colors.red,
                                    fontSize: widthStep * 35),),
                              PaddingBox(heightValue: 50,),
                              BlueButtonRounded(
                                buttonText: 'Close', buttonAction: () {
                                Navigator.pop(context);
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
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


