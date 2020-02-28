import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/fragments/BottomNavigation.dart';
import 'package:my_first_flutter_app/fragments/ApiCall.dart';
import 'package:my_first_flutter_app/fragments/ThirdFragment.dart';
import 'package:my_first_flutter_app/utils/ZoomScaffold.dart';
import 'package:provider/provider.dart';

class FancyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FancyDrawerStateful(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FancyDrawerStateful extends StatefulWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  final drawerItemModel = [
    new DrawerItemModel("Bottom Navigation", Icons.navigation),
    new DrawerItemModel("Api Call", Icons.list),
    new DrawerItemModel("Fragment 3", Icons.wallpaper)
  ];

  @override
  _FancyDrawerStateful createState() => new _FancyDrawerStateful();
}

class _FancyDrawerStateful extends State<FancyDrawerStateful>
    with TickerProviderStateMixin {
  MenuController menuController;
  int selectedDrawerIndex = 0;

  updateSelectedDrawerIndex(int index) {
    setState(() => selectedDrawerIndex = index);
    menuController.close();
    //Close the drawer
  }

  showDrawerFragment(int position) {
    switch (position) {
      case 0:
        return new BottomNavigation();
        break;
      case 1:
        return new ApiCall();
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

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItemModel.length; i++) {
      drawerOptions.add(
        new Column(
          children: <Widget>[
            new ListTile(
              leading:
                  new Icon(widget.drawerItemModel[i].icon, color: Colors.white),
              title: new Text(widget.drawerItemModel[i].title,
                  style: TextStyle(color: Colors.white)),
              selected: i == selectedDrawerIndex,
              onTap: () => updateSelectedDrawerIndex(i),
            ),
          ],
        ),
      );
    }
    return ChangeNotifierProvider(
      builder: (context) => menuController,
      child: ZoomScaffold(
        title: widget.drawerItemModel[selectedDrawerIndex].title,
        menuScreen: GestureDetector(
          onPanUpdate: (details) {
            //on swiping left
            if (details.delta.dx < -6) {
              Provider.of<MenuController>(context, listen: true).toggle();
            }
          },
          child: Container(
            padding: EdgeInsets.only(
                top: 62,
                left: 10,
                bottom: 8,
                right: MediaQuery.of(context).size.width / 2.9),
//            color: Color(0xff454dff),
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 16),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            "https://avatars2.githubusercontent.com/u/48587814?s=400&v=4"),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Hardik Talaviya',
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Column(children: drawerOptions),
                Spacer(),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text('Settings',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.headset_mic,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text('Support',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
//                color: Colors.white,
                child: showDrawerFragment(selectedDrawerIndex))),
      ),
    );
  }
}

class DrawerItemModel {
  String title;
  IconData icon;

  DrawerItemModel(this.title, this.icon);
}
