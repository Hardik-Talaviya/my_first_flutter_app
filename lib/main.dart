import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/pages/FancyDrawer.dart';
import 'package:my_first_flutter_app/pages/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashScreenStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreenStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenStatefulWidget();
  }
}

class _SplashScreenStatefulWidget extends State<SplashScreenStatefulWidget> {
  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  _autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isLogin')) {
      prefs.setBool('isLogin', false);
    }
    if (prefs.getBool('isLogin')) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FancyDrawer(),
            ));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 90.0,
              child: Image.asset(
                "assets/ic_launcher.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
                height: 15.0
            ),
            Text(
              'Splash Screen',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
