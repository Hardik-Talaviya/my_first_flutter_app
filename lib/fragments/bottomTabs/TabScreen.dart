import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget {
  final Color color;
  String title;
  TabScreen(this.title,this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child : Center(
        child:Text(
            title,style: TextStyle(fontSize: 20.0,color: color,fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}