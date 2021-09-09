import 'dart:convert';
import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/model/Town.dart';
import 'package:city_travel_guide/model/WikipediaAPI.dart';
import 'package:city_travel_guide/widgets/checkconnection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../category.dart';
import 'package:http/http.dart' as http;

class CityScreen extends StatefulWidget {
  final cityid;
  final cityname;
  final cityimage;
  final countryname;
  const CityScreen(
      {Key key, this.cityid, this.cityname, this.cityimage, this.countryname})
      : super(key: key);
  @override
  _CityScreen createState() => _CityScreen(
      cityid: this.cityid,
      cityname: this.cityname,
      cityimage: this.cityimage,
      countryname: this.countryname);
}

class _CityScreen extends State<CityScreen> {
  var cityid;
  var cityname;
  var cityimage;
  var countryname;
  _CityScreen({this.cityid, this.cityname, this.cityimage, this.countryname});
  Future<Post> futurePost;
  final checkconnection = CheckConnection();
  Future<Post> fetchPost() async {
    print("Fetching data from Wikipedia..");
    final response = await http.get(
        Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/$cityname'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Post.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw ('Failed to load Post');
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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Hero(
                        tag: 'text' + cityname,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(cityname,
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
                        tag: 'image' + cityimage,
                        child: Image.network(
                          "$cityimage",
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
              children: <Widget>[
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
                    child: FutureBuilder<List<Town>>(
                        future: dbHelper.getTowns(cityid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data.length > 0)
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Town towns = snapshot.data[index];
                                  return ListTile(
                                    title: Text("${towns.townName}"),
                                    subtitle: Text("$cityname, $countryname "),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage("${towns.townImageURL}"),
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      print(
                                          '${snapshot.data[index].townName} selected');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryScreen(
                                                    townid: snapshot
                                                        .data[index].townId,
                                                    townname: snapshot
                                                        .data[index].townName,
                                                    townimage: snapshot
                                                        .data[index]
                                                        .townImageURL)),
                                      );
                                    },
                                  );
                                });
                          else if (snapshot.hasData &&
                              snapshot.data.length == 0)
                            return Center(
                                child: Text("There are no towns available"));
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ));
                        }))
              ],
            )),
      ),
    );
  }
}
