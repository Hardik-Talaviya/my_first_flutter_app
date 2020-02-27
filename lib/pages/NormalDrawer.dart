import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/fragments/BottomNavigation.dart';
import 'package:my_first_flutter_app/fragments/SecondFragment.dart';
import 'package:my_first_flutter_app/fragments/ThirdFragment.dart';

class DrawerItemModel {
  String title;
  IconData icon;

  DrawerItemModel(this.title, this.icon);
}

class NormalDrawer extends StatefulWidget {
  final drawerItemModel = [
    new DrawerItemModel("Bottom Navigation", Icons.alarm),
    new DrawerItemModel("Fragment 2", Icons.info),
    new DrawerItemModel("Fragment 3", Icons.wallpaper)
  ];

  @override
  State<StatefulWidget> createState() {
    return NormalDrawerState();
  }
}

class NormalDrawerState extends State<NormalDrawer> {
  int selectedDrawerIndex = 0;

  showDrawerFragment(int position) {
    switch (position) {
      case 0:
        return new BottomNavigation();
        break;
      case 1:
        return new SecondFragment();
        break;
      case 2:
        return new ThirdFragment();
        break;
      default:
        return Center(
            child: Text(
          "No Fragment Found",
          style: TextStyle(color: Colors.red, fontSize: 18.0),
        ));
        break;
    }
  }

  updateSelectedDrawerIndex(int index) {
    setState(() => selectedDrawerIndex = index);
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } //Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItemModel.length; i++) {
      drawerOptions.add(
        new Column(
          children: <Widget>[
            new ListTile(
              leading: new Icon(widget.drawerItemModel[i].icon),
              title: new Text(widget.drawerItemModel[i].title),
              selected: i == selectedDrawerIndex,
              onTap: () => updateSelectedDrawerIndex(i),
            ),
//            new Divider(
//              height: 1,
//              thickness: 1.0,
//            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItemModel[selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Hardik Talaviya"),
              accountEmail: new Text("hardiktalaviya111@gmail.com"),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new ExactAssetImage('assets/nav_menu_header.jpg'),
                    fit: BoxFit.cover),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars2.githubusercontent.com/u/48587814?s=400&v=4"),
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: showDrawerFragment(selectedDrawerIndex),
    );
  }
}
