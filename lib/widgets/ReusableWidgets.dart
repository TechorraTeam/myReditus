import 'package:flutter/material.dart';
import 'package:reditus/widgets/HomePage.dart';
import 'package:search_map_place/search_map_place.dart';

//Text Input Fields
class InputTextField extends StatelessWidget {
  final double widthValue;
  final double heightValue;
  final double textSizeValue;
  final String hintTextValue;
  final IconData hintIcon;
  bool obscureText;

  InputTextField(
      {this.widthValue = 900,
      this.heightValue = 90,
      this.textSizeValue = 45,
      this.hintTextValue = 'E-mail',
      this.hintIcon = Icons.email,
      this.obscureText = false});

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
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
          child: TextField(
            controller: controller,
            cursorColor: Colors.black,
            obscureText: obscureText,
            style: TextStyle(fontSize: widthStep * textSizeValue),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                hintIcon,
                color: Colors.blue.shade500,
              ),
              border: InputBorder.none,
              hintText: hintTextValue,
              hintStyle: TextStyle(
                  fontSize: widthStep * 40, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextDetailedField extends StatelessWidget {
  final double widthValue;
  final double heightValue;
  final double textSizeValue;
  final String hintTextValue;
  final String labelTextValue;
  final IconData hintIcon;
  bool obscureText;

  InputTextDetailedField(
      {this.widthValue = 900,
      this.heightValue = 90,
      this.textSizeValue = 45,
      this.hintTextValue = 'John@gmail.com',
      this.hintIcon = Icons.email,
      this.labelTextValue = 'E-mail',
      this.obscureText = false,});

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
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
            Icon(hintIcon, color: Colors.blue.shade400,),
            Container (
              width: widthStep * 5,
              height: heightStep * heightValue,
              color: Colors.black12,
            ),
            Container(
              width: widthStep * widthValue*0.80,
              height: heightStep * heightValue*0.9,
              child: TextField(
                controller: controller,
                cursorColor: Colors.black,
                obscureText: obscureText,
                style: TextStyle(fontSize: widthStep * textSizeValue),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(widthStep*10),
                  labelText: labelTextValue,
                  labelStyle: TextStyle(
                      fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                  hintText: hintTextValue,
                  hintStyle: TextStyle(
                      fontSize: widthStep * 40, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputTextLocationField extends StatefulWidget {
  final double widthValue;
  final double heightValue;
  final double textSizeValue;
  final String hintTextValue;

  InputTextLocationField(
      {this.widthValue = 950,
        this.heightValue = 100,
        this.textSizeValue = 45,
        this.hintTextValue = 'Enter Location',
        });

  @override
  _InputTextLocationFieldState createState() => _InputTextLocationFieldState();
}

class _InputTextLocationFieldState extends State<InputTextLocationField> {
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: widthStep * widget.widthValue,
          height: heightStep * widget.heightValue,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widthStep * 15),
            border: Border.all(
              color: Colors.black12,
              width: widthStep * 5,
            ),
          ),
          child: Card(
            elevation: 0,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.red.shade300,),
                Container(
                  width: widthStep * 5,
                  height: heightStep * widget.heightValue*0.6,
                  color: Colors.black12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthStep * 20),
                  child: Container(
                    width: widthStep * widget.widthValue*0.75,
                    height: heightStep*widget.heightValue*0.90,
                    child: SingleChildScrollView(
                      child: SearchMapPlaceWidget(
                        apiKey: 'AIzaSyDV87cNktXWY8n3jbltsGrD8q7cBFKXn8k',
                        language: 'en',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


      ],
    );
  }
}

class InputSimpleTextField extends StatelessWidget {
  final double widthValue;
  final double heightValue;
  final double textSizeValue;
  final String hintTextValue;

  InputSimpleTextField(
      {this.widthValue = 900,
        this.heightValue = 90,
        this.textSizeValue = 45,
        this.hintTextValue = 'Enter Test Number',
      });

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
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
            width: widthStep * widthValue*0.9,
            height: heightStep * heightValue*0.9,
            child: TextField(
              controller: controller,
              cursorColor: Colors.black,
              style: TextStyle(fontSize: widthStep * textSizeValue),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintTextValue,
                hintStyle: TextStyle(
                    fontSize: widthStep * 40, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//App bar
Widget myAppBar(String textValue, double textSize, Function buttonAction,
    bool actionWidget, Function actionButtonFtn, IconData actionIcon, double elevationValue) {
  {
    return AppBar(
      title: SubTitleText(textValue, textSize),
      backgroundColor: Colors.white,
      elevation: elevationValue,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: widthStep * textSize,
        ),
        onPressed: buttonAction,
      ),
      actions: <Widget>[
        actionWidget
            ? (actionIcon == Icons.home)
                ? Padding(
                  padding: EdgeInsets.only(right: widthStep*30),
                  child: CircleAvatar(
                      backgroundColor: Colors.blue.shade700,
                      child: IconButton(
                        icon: Icon(
                          actionIcon,
                          color: Colors.white,
                          size: widthStep * textSize,
                        ),
                        onPressed: actionButtonFtn,
                      ),
                    ),
                )
                : IconButton(
                    icon: Icon(
                      actionIcon,
                      color: Colors.black54,
                      size: widthStep * (textSize + 15),
                    ),
                    onPressed: actionButtonFtn,
                  )
            : Container()
      ],
    );
  }
}

//Image Widgets
class TitleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * 900,
      height: heightStep * 150,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('Assets/myReditusPng.png'),
        fit: BoxFit.contain,
      )),
    );
  }
}

class ImageHolder extends StatelessWidget {
  final double widthValue, heightValue;
  final String imagePath;

  ImageHolder(
      {this.widthValue = 200.0,
      this.heightValue = 75.0,
      this.imagePath = 'Assets/TestIcon.png'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ImageHolderGradient extends StatelessWidget {
  final double widthValue, heightValue;
  final String imagePath;
  final double textSize;
  final String textValue;

  ImageHolderGradient(
      {this.widthValue = 650.0,
        this.heightValue = 400.0,
        this.imagePath = 'Assets/Address Icon.png',
      this.textSize = 65,
      this.textValue = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: widthStep * widthValue*0.7,
            height: heightStep * heightValue*0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SubTitleText(textValue, textSize),
          PaddingBox(heightValue: 40,),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white, Color(0xc1d3ee)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(widthStep*500),
      ),
    );
  }
}

//Text Widgets
class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Reditus',
      style: TextStyle(
          color: Colors.blue.shade900,
          fontSize: widthStep * 150,
          fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,

    );
  }
}

class SubTitleText extends StatelessWidget {
  final String textValue;
  final double sizeValue;
  SubTitleText(this.textValue, this.sizeValue);
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(
          color: Colors.black87,
          fontSize: widthStep * sizeValue,
          fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,

    );
  }
}

class SimpleText extends StatelessWidget {
  final String textValue;
  final double sizeValue;
  SimpleText({this.textValue, this.sizeValue = 30});
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(
          color: Colors.black87,
          fontSize: widthStep * sizeValue,
          fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
    );
  }
}

class SimpleItalicText extends StatelessWidget {
  final String textValue;
  final double sizeValue;
  SimpleItalicText({this.textValue, this.sizeValue = 30});
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(
          color: Colors.black87,
          fontSize: widthStep * sizeValue,
          fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }
}

//Button Widgets
class ButtonImageHolder extends StatelessWidget {
  final String buttonText;
  final double widthValue;
  final double heightValue;
  final Function buttonAction;
  final String imagePath;

  ButtonImageHolder(
      {this.buttonText = '',
      this.widthValue = 800,
      this.heightValue = 350,
      this.imagePath = 'Assets/TestIcon.png',
      this.buttonAction});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      child: RaisedButton(
        onPressed: buttonAction,
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(widthStep * widthValue * 0.05),
            side: BorderSide(color: Colors.grey.shade100)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: widthStep * widthValue * 0.8,
              height: heightStep * heightValue * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: widthStep * widthValue * 0.9,
              height: heightStep * 2,
              color: Colors.black12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: widthStep * 5,
                ),
                Container(
                  width: widthStep*widthValue*0.6,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: widthStep * 40,
                        fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.blue.shade900,
                  size: widthStep * 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BlueButtonRounded extends StatelessWidget {
  final String buttonText;
  final double widthValue;
  final double heightValue;
  final Function buttonAction;

  BlueButtonRounded(
      {this.buttonText = '',
      this.widthValue = 900,
      this.heightValue = 90,
      this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(12, 84, 231, 1), Color.fromRGBO(75, 127, 231, 1), Color.fromRGBO(127, 170, 255, 1)],
        ),
        borderRadius: BorderRadius.circular(widthStep * 100),
      ),
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 20,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: widthStep * 5,
            ),
            Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: widthStep * 45,
                  fontWeight: FontWeight.w400),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: widthStep * 35,
            ),
          ],
        ),
        onPressed: buttonAction,
      ),
    );
  }
}

class RedButtonRounded extends StatelessWidget {
  final String buttonText;
  final double widthValue;
  final double heightValue;
  final IconData leadIcon;
  final IconData trailIcon;
  final Function actionButton;
  RedButtonRounded(
      {this.buttonText = '',
      this.widthValue = 900,
      this.heightValue = 90,
      this.leadIcon,
      this.trailIcon = Icons.arrow_forward_ios,
      this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(255, 38, 0, 1), Color.fromRGBO(255, 156, 156, 1)],
        ),
        borderRadius: BorderRadius.circular(widthStep * 100),
      ),
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 15,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: (leadIcon == null)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (leadIcon != null)
                ? Icon(
                    leadIcon,
                    color: Colors.white,
                    size: widthStep * 70,
                  )
                : Container(),
            Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: widthStep * 45,
                  fontWeight: FontWeight.w400),
            ),
            (trailIcon != null && leadIcon == null)
                ? Icon(
                    trailIcon,
                    color: Colors.white,
                    size: widthStep * 30,
                  )
                : Container(),
          ],
        ),
        onPressed: actionButton,
      ),
    );
  }
}

class GreenButtonRounded extends StatelessWidget {
  final String buttonText;
  final double widthValue;
  final double heightValue;
  final IconData leadIcon;
  final IconData trailIcon;
  final Function actionButton;

  GreenButtonRounded(
      {this.buttonText = '',
      this.widthValue = 900,
      this.heightValue = 90,
      this.leadIcon,
      this.trailIcon = Icons.arrow_forward_ios,
      this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(12, 84, 231, 1), Color.fromRGBO(75, 127, 231, 1), Color.fromRGBO(127, 170, 255, 1)],
        ),
        borderRadius: BorderRadius.circular(widthStep * 100),
      ),
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 15,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: (leadIcon == null)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (leadIcon != null)
                ? Icon(
                    leadIcon,
                    color: Colors.white,
                    size: widthStep * 70,
                  )
                : Container(),
            Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: widthStep * 45,
                  fontWeight: FontWeight.w400),
            ),
            (trailIcon != null && leadIcon == null)
                ? Icon(
                    trailIcon,
                    color: Colors.white,
                    size: widthStep * 30,
                  )
                : Container(),
          ],
        ),
        onPressed: actionButton,
      ),
    );
  }
}

class WhiteButtonCurved extends StatelessWidget {
  final String buttonText;
  final double widthValue;
  final double heightValue;
  final Function actionButton;
  final IconData trailingIcon;

  WhiteButtonCurved(
      {this.buttonText = '', this.widthValue = 900, this.heightValue = 90, this.actionButton, this.trailingIcon = Icons.arrow_forward});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
      child: RaisedButton(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(widthStep * 20),
            side: BorderSide(color: Colors.grey.shade300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PaddingBox(widthValue: 50,),
            Container(
              width: widthStep*700,
              child: Text(
                buttonText,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: widthStep * 45,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Icon(
              trailingIcon,
              color: Colors.blue.shade800,
              size: widthStep * 40,
            ),
          ],
        ),
        onPressed: actionButton,
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  var colorValue = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * 850,
      height: heightStep * 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widthStep * 100),
          border: Border()),
      child: RaisedButton(
        color: Colors.white,
        elevation: 15,
        shape: StadiumBorder(
          side: BorderSide(color: colorValue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: widthStep * 70,
              child: CircleAvatar(
                backgroundColor: colorValue,
                child: Text(
                  'f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widthStep * 60,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(
              'Login With Facebook',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: widthStep * 40,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: widthStep * 5,
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  var colorValue = Colors.red.shade700;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * 850,
      height: heightStep * 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widthStep * 100),
          border: Border()),
      child: RaisedButton(
        color: Colors.white,
        elevation: 15,
        shape: StadiumBorder(
          side: BorderSide(color: colorValue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: widthStep * 70,
              child: CircleAvatar(
                backgroundColor: colorValue,
                child: Text(
                  'G',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widthStep * 60,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(
              'Login With Google',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: widthStep * 40,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: widthStep * 5,
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  var colorValue = Colors.lightBlue.shade700;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthStep * 850,
      height: heightStep * 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widthStep * 100),
          border: Border()),
      child: RaisedButton(
        color: Colors.white,
        elevation: 15,
        shape: StadiumBorder(
          side: BorderSide(color: colorValue),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.black,
              fontSize: widthStep * 40,
              fontWeight: FontWeight.w400),
        ),
        onPressed: () {},
      ),
    );
  }
}

//Padding
class PaddingBox extends StatelessWidget {
  final double widthValue, heightValue;
  PaddingBox({this.widthValue = 10, this.heightValue = 10});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthStep * widthValue,
      height: heightStep * heightValue,
    );
  }
}

//Dropdown Button
class DropDownButton extends StatefulWidget {

  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String dropdownValue = 'Select Your Temperature';

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widthStep * 600,
        height: heightStep * 80,
        child: DropdownButton<String>(
          elevation: 10,
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Select Your Temperature', "98.7F (37.06C)",
            "98.8F (37.11C)",
            "98.9F (37.17C)",
            "99F (37.22C)",
            "99.1F (37.28C)",
            "99.2F (37.33C)",
            "99.3F (37.39C)",
            "99.4F (37.44C)",
            "99.5F (37.5C)",
            "99.6F (37.56C)",
            "99.7F (37.61C)",
            "99.8F (37.67C)",
            "99.9F (37.72C)",
            "100F (37.78C)",
            "100.1F (37.83C)",
            "100.2F (37.89C)",
            "100.3F (37.94C)",
            "100.4F (38C)",
            "100.5F (38.06C)",
            "100.6F (38.11C)",
            "100.7F (38.17C)",
            "100.8F (38.22C)",
            "100.9F (38.28C)",
            "101F (38.33C)",
            "101.1F (38.39C)",
            "101.2F (38.44C)",
            "101.3F (38.5C)",
            "101.4F (38.56C)",
            "101.5F (38.61C)",
            "101.6F (38.67C)",
            "101.7F (38.72C)",
            "101.8F (38.78C)",
            "101.9F (38.83C)",
            "102F (38.89C)",
            "102.1F (38.94C)",
            "102.2F (39C)",
            "102.3F (39.06C)",
            "102.4F (39.11C)",
            "102.5F (39.17C)",
            "102.6F (39.22C)",
            "102.7F (39.28C)",
            "102.8F (39.33C)",
            "102.9F (39.39C)",
            "103F (39.44C)",
            "103.1F (39.5C)",
            "103.2F (39.56C)",
            "103.3F (39.61C)",
            "103.4F (39.67C)",
            "103.5F (39.72C)",
            "103.6F (39.78C)",
            "103.7F (39.83C)",
            "103.8F (39.89C)",
            "103.9F (39.94C)",
            "104F (40C)"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
              .toList(),
        ),

    );
  }
}

