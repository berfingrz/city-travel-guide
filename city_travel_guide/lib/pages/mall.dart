import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/model/Mall.dart';
import 'package:city_travel_guide/pages/info/mallinfo.dart';
import 'package:flutter/material.dart';

class MallPage extends StatefulWidget {
  final categoryid;

  const MallPage({
    Key key,
    this.categoryid,
  }) : super(key: key);

  @override
  _MallPage createState() => _MallPage(categoryid: this.categoryid);
}

class _MallPage extends State<MallPage> {
  var categoryid;
  _MallPage({
    this.categoryid,
  });

  final dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mall',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: buildBody());
  }

  buildBody() {
    return FutureBuilder<List<Mall>>(
        future: dbHelper.getMall(categoryid),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.length >
                  0) // This ensures that you have at least one or more countries available.
            return SizedBox(
              height: 700,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Mall places = snapshot.data[index];
                  return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                title: Hero(
                                  tag: 'text' + places.mallName,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text('${places.mallName}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                subtitle: Text('${places.mallLocation}'),
                                leading: Icon(
                                  Icons.place,
                                  color: Colors.blue[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              fullscreenDialog: true,
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return MallInfo(
                                  places: places,
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
                      ));
                },
              ),
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
