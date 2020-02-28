import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Api Call',
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          body: new Container(
            color: Colors.white,
        child: new FutureBuilder<List<BeerListModel>>(
          future: fetchUsersFromGithub(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].tagline),
                            leading: Container(
                                margin: EdgeInsets.only(left: 6.0),
                                child: Image.network(
                                  snapshot.data[index].image_url,
                                  height: 50.0,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        new Divider(height: 30,color: Colors.grey)
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )),
    );
  }
}

Future<List<BeerListModel>> fetchUsersFromGithub() async {
  final response = await http.get('https://api.punkapi.com/v2/beers');
  print(response.body);
  List responseJson = json.decode(response.body.toString());
  List<BeerListModel> beerList = createUserList(responseJson);
  return beerList;
}

List<BeerListModel> createUserList(List responseJson) {
  List<BeerListModel> userList = new List();

  for (int i = 0; i < responseJson.length; i++) {
    int id= responseJson[i]["id"];
    String name= responseJson[i]["name"];
    String tagline= responseJson[i]["tagline"];
    String description= responseJson[i]["description"];
    String image_url= responseJson[i]["image_url"];
    BeerListModel userListModel = new BeerListModel(id:id,name: name,tagline: tagline,description: description,image_url: image_url);
    userList.add(userListModel);
  }
  return userList;
}

class BeerListModel {
  int id;
  String name;
  String tagline;
  String description;
  String image_url;

  BeerListModel({this.id, this.name,this.tagline,this.description,this.image_url});
}
