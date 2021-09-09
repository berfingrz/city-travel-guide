import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/model/Country.dart';
import 'package:city_travel_guide/pages/selectcity.dart';
import 'package:city_travel_guide/widgets/checkconnection.dart';
import 'package:city_travel_guide/widgets/splashscreen.dart';
import 'package:flutter/material.dart';
import 'widgets/maindrawer.dart';
import 'pages/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'City Travel Guide',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: MySplash());
  }
}

class MyHome extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<MyHome> {
  final dbHelper = DbHelper();
  final checkconnection = CheckConnection();

  @override
  void initState() {
    dbHelper.initDb();
    checkconnection.checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select a Country',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                }),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        drawer: Drawer(child: MainDrawer()),
        body: buildBody());
  }

  buildBody() {
    return FutureBuilder<List<Countries>>(
        future: dbHelper.getCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.length >
                  0) // This ensures that you have at least one or more countries available.
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Countries country = snapshot.data[index];
                    return GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 3.0,
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 120.0,
                              child: Hero(
                                tag: 'image' + country.countryImageURL,
                                child: Image.network(
                                    '${country.countryImageURL}',
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                                child: Center(
                                    child: Hero(
                              tag: 'text' + country.countryName,
                              child: Material(
                                color: Colors.transparent,
                                child: Text('${country.countryName}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            )))
                          ],
                        ),
                      ),
                      onTap: () {
                        print('${snapshot.data[index].countryName} selected');
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectCity(
                                  countryid: snapshot.data[index].countryId,
                                  countryname: snapshot.data[index].countryName,
                                  countryimage:
                                      snapshot.data[index].countryImageURL)),
                        );*/
                        Navigator.of(context).push(PageRouteBuilder(
                            fullscreenDialog: true,
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return SelectCity(
                                countryid: snapshot.data[index].countryId,
                                countryname: snapshot.data[index].countryName,
                                countryimage:
                                    snapshot.data[index].countryImageURL,
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
                      },
                    );
                  }),
            );
          else if (snapshot.hasData && snapshot.data.length == 0)
            return Center(child: Text("There are no countries available"));
          return Center(
              child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          )); // This would display a loading animation before your data is ready
        });
  }
}
