import 'dart:async';
import 'package:city_travel_guide/data/database_helper.dart';
import 'package:city_travel_guide/model/Parks.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:city_travel_guide/widgets/checkconnection.dart';
import 'package:city_travel_guide/pages/comment/test.dart';

class ParkInfo extends StatefulWidget {
  final Parks places;

  ParkInfo({Key key, this.places}) : super(key: key);
  @override
  _ParkInfo createState() => _ParkInfo(places: this.places);
}

class _ParkInfo extends State<ParkInfo> {
  Parks places;
  _ParkInfo({this.places});
  final dbHelper = DbHelper();
  final checkconnection = CheckConnection();

  /*initMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
    await availableMaps.first.showMarker(
        coords: Coords(37.759392, -122.5107336), title: "Ocean Beach");
  }*/

  LatLng _center = LatLng(36.5433484369784, 31.98768698387);

  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = {};

  void onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  void initState() {
    checkconnection.checkConnection();
    onAddMarkerButtonPressed();
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
                      title: Hero(
                        tag: 'text' + places.parkName,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(places.parkName,
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
                        tag: 'image' + places.parkName,
                        child: Image.network(
                          "${places.parkName}",
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
                Expanded(
                    child: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Info:',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            )),
                        Card(
                            elevation: 3.0,
                            color: Theme.of(context).backgroundColor,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.map_outlined),
                                  title: Text("${places.parkLocation}"),
                                  dense: true,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'See on Map:',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 200.0,
                          child: Card(
                            child: GoogleMap(
                              markers: _markers,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition:
                                  CameraPosition(target: _center, zoom: 17.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 3.0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.room_outlined),
                        label: Text(
                          'Navigation',
                        ),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(150.0, 40.0)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestMe()));
                        },
                        icon: Icon(Icons.comment_outlined),
                        label: Text(
                          'Comments',
                        ),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(150.0, 40.0)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                      ),
                    ],
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
