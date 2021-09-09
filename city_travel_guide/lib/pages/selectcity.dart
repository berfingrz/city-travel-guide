import 'dart:convert';
import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/model/City.dart';
import 'package:city_travel_guide/model/WikipediaAPI.dart';
import 'package:city_travel_guide/pages/info/cityinfo.dart';
import 'package:city_travel_guide/widgets/checkconnection.dart';
import 'package:city_travel_guide/widgets/maindrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SelectCity extends StatefulWidget {
  final countryid;
  final countryname;
  final countryimage;
  const SelectCity(
      {Key key, this.countryid, this.countryname, this.countryimage})
      : super(key: key);
  @override
  _SelectCity createState() => _SelectCity(
      countryid: this.countryid,
      countryname: this.countryname,
      countryimage: this.countryimage);
}

class _SelectCity extends State<SelectCity> {
  var countryid;
  var countryname;
  var countryimage;
  _SelectCity({this.countryid, this.countryname, this.countryimage});
  Future<CheckConnection> check;
  final checkconnection = CheckConnection();
  Future<Post> futurePost;
  Future<Post> fetchPost() async {
    print("Fetching data from Wikipedia..");
    final response = await http.get(Uri.https(
        'en.wikipedia.org', '/api/rest_v1/page/summary/$countryname'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Post');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
    checkconnection.checkConnection();
  }

  final dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: Drawer(child: MainDrawer()), body: buildBody());
  }

  buildBody() {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Hero(
                    tag: 'text' + countryname,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(countryname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          )),
                    ),
                  ),
                  background: Hero(
                    tag: 'image' + countryimage,
                    child: Image.network(
                      "$countryimage",
                      fit: BoxFit.cover,
                    ),
                  )),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
              ],
            ),
          ];
        },
        body: Column(
          children: [
            Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3.0,
                child: FutureBuilder<Post>(
                    future: futurePost,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data.title);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 15.0,
                            ),
                            ListTile(
                              leading: Icon(Icons.info),
                              title: Text("About"),
                              subtitle: Text(snapshot.data.extract),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () async {
                                    String url =
                                        '${snapshot.data.content.mobile.page}';
                                    if (await canLaunch(url)) {
                                      await launch(url,
                                          forceWebView: true,
                                          enableJavaScript: true);
                                    } else {
                                      throw 'Could not launch url';
                                    }
                                  },
                                  child: Text("Wikipedia"),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        );
                      }
                      return SizedBox(
                        child: CircularProgressIndicator(),
                        height: 15.0,
                        width: 15.0,
                      );
                    })),
            Expanded(
              child: FutureBuilder<List<City>>(
                  future: dbHelper.getCities(countryid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.length >
                            0) // This ensures that you have at least one or more countries available.
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          City cities = snapshot.data[index];
                          return ListTile(
                              title: Hero(
                                tag: 'text' + cities.cityName,
                                child: Material(
                                    color: Colors.transparent,
                                    child: Text('${cities.cityName}')),
                              ),
                              subtitle: Text(countryname),
                              leading: Hero(
                                tag: 'image' + cities.cityImageURL,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("${cities.cityImageURL}"),
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    fullscreenDialog: true,
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return CityScreen(
                                        cityid: snapshot.data[index].cityId,
                                        cityname: snapshot.data[index].cityName,
                                        countryname: countryname,
                                        cityimage:
                                            snapshot.data[index].cityImageURL,
                                      );
                                    },
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation,
                                        Widget child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    }));
                              });
                        },
                      );
                    else if (snapshot.hasData && snapshot.data.length == 0)
                      return Center(
                          child: Text("There are no countries available"));
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    )); // This would display a loading animation before your data is ready
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
