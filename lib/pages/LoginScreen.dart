import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/pages/SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FancyDrawer.dart';

class LoginScreen extends StatelessWidget {
  static const String _title = 'Flutter Demo';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: _title,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      home: LoginScreenStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreenStatefulWidget extends StatefulWidget {
  LoginScreenStatefulWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenStatefulWidget();
  }
}

class _LoginScreenStatefulWidget extends State<LoginScreenStatefulWidget> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 17.0);
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _setIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.setString('email', emailController.text.trim());
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FancyDrawer(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          if (emailController.text.trim().isNotEmpty &&
              passController.text.trim().isNotEmpty) {
            _setIsLogin();
          } else {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Require Email & Password')));
          }
        },
        child: Text("LOGIN",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0)),
      ),
    );

    final signUp = Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
//                  builder: (context) => NormalDrawer(),
                ));
          },
          child: Text("Don't have account? Click here",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16.0, color: Colors.blue,fontWeight: FontWeight.bold)),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,30.0,30.0,0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                    child: Image.asset(
                      "assets/ic_launcher.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButton,
                ],
              ),
            ),
            signUp,
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
