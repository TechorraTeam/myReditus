import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String url = "https://reditus.azurewebsites.net/api/MobileApplication/AppScreenWording/-1";
const idToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuYkBzZWRvbGFicy5jb20iLCJqdGkiOiI5ZmNmMzY5Ny0wYjQ1LTQxMTUtOTg5Zi01MWViMzNmNDFkYzgiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6WyJmNWE5NTJjMC1jMzFiLTRjNzctOGE3Yi04YTI0YTU1NTc1YjgiLCJmNWE5NTJjMC1jMzFiLTRjNzctOGE3Yi04YTI0YTU1NTc1YjgiXSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6Im5iQHNlZG9sYWJzLmNvbSIsInVzZXJpZCI6ImY1YTk1MmMwLWMzMWItNGM3Ny04YTdiLThhMjRhNTU1NzViOCIsImVtYWlsIjoibmJAc2Vkb2xhYnMuY29tIiwiZmlyc3RuYW1lIjoiTmljayIsImNsaWVudGlkIjoiMSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6WyJTdXBlckFkbWluIiwiQWRtaW4iLCJVc2VyIl0sImV4cCI6MTU5NzA3NDA1MSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.BkwIGdWq6QkiYUNNvmR7IK_EpswdiYPQiX73B93KTY4';

class GetData {
  static var myData;
  static bool dataLoaded = false;
}

class LoginData {
  static var myData;
  static bool dataLoaded = false;
}

Future<bool> login(String email, String password) async{
  Map<String, String> headerParams = {
    "Content-Type": 'application/json',
  };
  http.Response response = await http.post('https://reditus.azurewebsites.net/api/Auth/Login',
    headers: headerParams,
    body: json.encode({
      "email": email,
      "password": password
    })
  );

  var data = json.decode(response.body);
  print(data);
  if (response.statusCode == 200){
    LoginData.myData = data;
    LoginData.dataLoaded = true;
  }
  else {
    LoginData.dataLoaded = false;
    LoginData.myData = null;
  }
  return LoginData.dataLoaded;
}

Future<dynamic> getOtherData(String url, String tokenID, String indexValue) async{
  var data;
  http.Response response = await http.get(url+'/'+indexValue,
    headers: {HttpHeaders.authorizationHeader: tokenID},
  );
  if(response.statusCode == 200)
    data = json.decode(response.body);
  else
    data = null;

  return data;
}

Future<bool> postData (String url, String tokenID, String indexValue, Map<String, dynamic> body) async{
  Map<String, String> headerParams = {
    "Content-Type": 'application/json',
  };

  http.Response response = await http.post(url+'/'+indexValue,
    headers: headerParams,
    body: json.encode(body),
  );
  if (response.statusCode == 200)
    return true;
  else
    return false;
}

Future<bool> deleteData (String url, String tokenID, String indexValue) async{
  Map<String, String> headerParams = {
    "Content-Type": 'application/json',
  };

  http.Response response = await http.delete(url+'/'+indexValue,
    headers: headerParams,
  );
  if (response.statusCode == 200)
    return true;
  else
    return false;
}

Future<bool> putData (String url, String tokenID, String indexValue, Map<String, dynamic> body) async{
  Map<String, String> headerParams = {
    "Content-Type": 'application/json',
  };

  http.Response response = await http.put(url+'/'+indexValue,
      headers: headerParams,
      body: json.encode(body),
  );
  if (response.statusCode == 200)
    return true;
  else
    return false; 
}

Future<bool> getJsonData() async {
  http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
  );

  List data = json.decode(response.body);
  GetData.myData = data;
  if (response.statusCode == 200)
    GetData.dataLoaded = true;
  else {
    GetData.dataLoaded = false;
  }
  return GetData.dataLoaded;
}


class DataTest extends StatefulWidget {

  @override
  _DataTestState createState() => _DataTestState();
}

class _DataTestState extends State<DataTest> {
  Map<String, dynamic> body = {
    "id": 16,
    "employeeId": 16,
    "employeeVerifiedOn": "2020-05-16T21:10:20.527Z",
    "sendOutOn": DateTime.now().toString(),
    "takenOn": DateTime.now().toString(),
    "result": "negative",
    "fileGuid": "",
    "testCode": ""
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: RaisedButton(
          child: Text('Press'),
          onPressed: () async {
            //login('nb@sedolabs.com', 'password').then((value) {
             // print(value);
            //  print(LoginData.myData);
           // });
            //var data = await postOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Visit', '');
            //var data = await getOtherData('https://reditus.azurewebsites.net/api/MobileApplication/Address/', idToken, '1');
            //print (data);
            //print(data[0]['item2']);
            postData('https://reditus.azurewebsites.net/api/MobileApplication/Test', '', '16', body).
            then((value) => print(value));
          },
        ),
      ),
    );
  }
}

