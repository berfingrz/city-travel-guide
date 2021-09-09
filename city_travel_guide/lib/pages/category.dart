import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/model/Categories.dart';
import 'package:city_travel_guide/pages/historicalplaces.dart';
import 'package:city_travel_guide/pages/hospital.dart';
import 'package:city_travel_guide/pages/parks.dart';
import 'package:city_travel_guide/pages/police.dart';
import 'package:city_travel_guide/pages/restaurants.dart';
import 'package:city_travel_guide/pages/mall.dart';
import 'package:city_travel_guide/widgets/checkconnection.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final categoryid;
  final categoryname;
  final townid;
  final townname;
  final townimage;
  const CategoryScreen(
      {Key key,
      this.townimage,
      this.categoryid,
      this.categoryname,
      this.townid,
      this.townname})
      : super(key: key);
  @override
  _CategoryScreen createState() => _CategoryScreen(
      townimage: this.townimage,
      categoryid: this.categoryid,
      categoryname: this.categoryname,
      townid: this.townid,
      townname: this.townname);
}

class _CategoryScreen extends State<CategoryScreen> {
  var townimage;
  var categoryid;
  var categoryname;
  var townid;
  var townname;
  _CategoryScreen(
      {this.townimage,
      this.categoryid,
      this.categoryname,
      this.townid,
      this.townname});

  final dbHelper = DbHelper();
  final checkconnection = CheckConnection();

  @override
  void initState() {
    checkconnection.checkConnection();
    super.initState();
  }

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
                        title: Text("$townname",
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
                        background: Image.network(
                          "$townimage",
                          fit: BoxFit.cover,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Some information again."),
                            subtitle: Text('What can user do?'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {},
                                child: Text("Navigation"),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      child: FutureBuilder<List<Categories>>(
                          future: dbHelper.getCategories(townid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data.length > 0)
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Categories categories = snapshot.data[index];
                                  return ListTile(
                                    onTap: () {
                                      print(
                                          '${snapshot.data[index].categoriesName} selected');
                                      if (snapshot.data[index].categoriesName ==
                                          'HistoricalPlaces') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HistoryPage(
                                                  categoryid:
                                                      categories.categoriesId)),
                                        );
                                      }
                                      if (snapshot.data[index].categoriesName ==
                                          'Hospital') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HospitalPage(
                                                      categoryid: categories
                                                          .categoriesId)),
                                        );
                                      }
                                      if (snapshot.data[index].categoriesName ==
                                          'Parks') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ParksPage(
                                                  categoryid:
                                                      categories.categoriesId)),
                                        );
                                      }
                                      if (snapshot.data[index].categoriesName ==
                                          'Police') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PolicePage(
                                                  categoryid:
                                                      categories.categoriesId)),
                                        );
                                      }
                                      if (snapshot.data[index].categoriesName ==
                                          'Restaurant') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RestaurantsPage(
                                                      categoryid: categories
                                                          .categoriesId)),
                                        );
                                      }
                                      if (snapshot.data[index].categoriesName ==
                                          'ShoppingMalls') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MallPage(
                                                  categoryid:
                                                      categories.categoriesId)),
                                        );
                                      }
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '${categories.categoriesImageURL}'),
                                    ),
                                    title: Text("${categories.categoriesName}"),
                                    subtitle: Text("Tap for more"),
                                    dense: true,
                                  );
                                },
                              );
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.favorite_outline),
          backgroundColor: Theme.of(context).backgroundColor,
        ));
  }
}

/*child: ListView(
                    children: [
                      ListTile(
                        onTap: () {
                          
                        },
                        leading: Icon(Icons.place),
                        title: Text("Historical Places"),
                        subtitle: Text("Some Instagram stuff in $townname"),
                        dense: true,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.airplanemode_active_outlined),
                        title: Text("Transportation"),
                        subtitle: Text("Can I get a taxi?"),
                        dense: true,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.grade_rounded),
                        title: Text("Parks"),
                        subtitle: Text("Breathe and relax..."),
                        dense: true,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.restaurant,
                        ),
                        title: Text("Restaurants"),
                        subtitle:
                            Text("Would you like to have dinner outside?"),
                        dense: true,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.shopping_bag,
                        ),
                        title: Text("Shopping malls"),
                        subtitle: Text("What should I wear today?"),
                        dense: true,
                      ),
                    ],
                  ) */
