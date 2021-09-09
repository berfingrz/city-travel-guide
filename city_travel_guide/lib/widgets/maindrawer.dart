import 'package:flutter/material.dart';

bool isSwitched = false;

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.deepPurple,
              Colors.deepPurpleAccent
            ])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    elevation: 10,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/cascade.png'),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Cascade",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Team 6",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/");
          },
          leading: Icon(Icons.home_outlined),
          title: Text("Home"),
          dense: true,
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/information");
          },
          leading: Icon(Icons.home_outlined),
          title: Text("Information"),
          dense: true,
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/profile");
          },
          leading: Icon(
            Icons.person,
          ),
          title: Text("Profile"),
          dense: true,
        ),
        Container(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.nightlight_round),
                      title: Text('Dark Mode'),
                      trailing: Switch(
                        value: isSwitched,
                        onChanged: (value) {},
                        activeTrackColor: Colors.deepPurpleAccent,
                        activeColor: Colors.deepPurpleAccent[700],
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }
}
