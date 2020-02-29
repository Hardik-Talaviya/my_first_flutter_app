import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FancyDrawer.dart';

var globalContext;

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      home: SignUpScreenState(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreenState extends StatefulWidget {
  @override
  _SignUpScreenStateState createState() => _SignUpScreenStateState();
}

class _SignUpScreenStateState extends State<SignUpScreenState> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 17.0);
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController contactNumberController =
      new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _setSignUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FancyDrawer(),
//                  builder: (context) => NormalDrawer(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          labelText: 'First Name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final lastNameField = TextFormField(
      controller: lastNameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          labelText: 'Last Name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final emailField = TextFormField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          labelText: 'Email',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final passwordField = TextFormField(
      controller: passController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          labelText: 'Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final contactNumberField = TextFormField(
      keyboardType: TextInputType.number,
      controller: contactNumberController,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          labelText: 'Contact Number',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
//      color: Color(0xff01A0C7),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          if (emailController.text.trim().isNotEmpty &&
              passController.text.trim().isNotEmpty) {
            _setSignUp();
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Require Email & Password')));
          }
        },
        child: Text("SIGNUP",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0)),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('SignUp'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(globalContext).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              firstNameField,
              SizedBox(height: 20.0),
              lastNameField,
              SizedBox(height: 20.0),
              emailField,
              SizedBox(height: 20.0),
              passwordField,
              SizedBox(height: 20.0),
              contactNumberField,
              SizedBox(height: 35.0),
              signUpButton,
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
