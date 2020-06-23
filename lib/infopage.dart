import 'package:dream_home/calculator.dart';
import 'package:flutter/material.dart';
import 'house.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InfoPage extends StatefulWidget {
  final House house;
  const InfoPage({Key key, this.house}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List locdata;

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    double lat = double.parse(widget.house.latitude);
    double log = double.parse(widget.house.longitude);

    setState(() {
      _markers.clear();

      final marker = Marker(
        markerId: MarkerId(widget.house.name),
        position: LatLng(lat, log),
        infoWindow: InfoWindow(
          title: widget.house.name,
          snippet: widget.house.address,
        ),
      );
      _markers[widget.house.name] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return Scaffold(
        appBar: AppBar(
          title: Text('Details Description'),
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Container(
            //alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26,
                image: DecorationImage(
                    image: NetworkImage(
                        "http://yitengsze.com/cteng/homeimage/${widget.house.imagename}?"),
                    fit: BoxFit.fill)),
            height: 350,
          ),
          SizedBox(
            height: 15,
          ),
          Card(
            child: Table(defaultColumnWidth: FlexColumnWidth(1.0),
                //columnWidths: {
                // 0: FlexColumnWidth(8),
                //1: FlexColumnWidth(6.5),
                //},
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Column(mainAxisSize: MainAxisSize.min,

                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              alignment: Alignment.topLeft,
                              //height: 150,
                              child: Text(
                                  "RM " +
                                      (formatter.format(
                                          int.parse(widget.house.price))),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ])),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Column(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              //height: 150,
                              child: Text(widget.house.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ])),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              alignment: Alignment.topLeft,
                              //height: 150,
                              child: Text(widget.house.address,
                                  style: TextStyle(
                                      fontSize: 16,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ])),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Column(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              //height: 150,
                              child: Text(widget.house.type,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ])),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Column(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              alignment: Alignment.topLeft,
                              //height: 150,
                              child: Text("Built-up Size: " + widget.house.area,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ])),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                          Icon(
                            MdiIcons.bedDoubleOutline,
                            // size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              alignment: Alignment.center,
                              //height: 150,
                              child: Text(widget.house.room,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            MdiIcons.shower,
                            // size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              alignment: Alignment.center,
                              //height: 150,
                              child: Text(widget.house.broom,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            MdiIcons.car,
                            // size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              alignment: Alignment.center,
                              //height: 150,
                              child: Text(widget.house.cpark,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          SizedBox(
                            height: 10,
                          ),
                        ])),
                  ]),
                ]),
          ),
          Card(
              child: ListTile(
                  leading: Icon(MdiIcons.calculator),
                  title: Text(
                    "Mortgage Calculator",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Calculator()));
                  })),
          Card(
              child: Column(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
            ),
            SizedBox(
              height: 5,
            ),
            Text("For more details:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 5,
            ),
            Table(defaultColumnWidth: FlexColumnWidth(1.0), columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(6.5),
            }, children: [
              TableRow(children: [
                TableCell(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.link,
                        // size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          alignment: Alignment.center,

                          // height: 40,
                          child: Text("URL: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                  ),
                ),
                TableCell(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _launchInUrl("https://${widget.house.url}?"),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        //height: 40,
                        child: Text(widget.house.url,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white)),
                      ),
                    )
                  ],
                )),
              ]),
              TableRow(children: [
                TableCell(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.phone,
                        // size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          child: Text("Phone: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                  ),
                ),
                TableCell(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    GestureDetector(
                      onTap: () => _callPhone(context),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        //height: 20,
                        child: Text(widget.house.contact,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white)),
                      ),
                    ),
                  ]),
                )
              ]),
            ]),
            SizedBox(
              height: 15,
            ),
            _googleMap(context),
            SizedBox(
              height: 10,
            ),
            Card(
                child: Table(
                    defaultColumnWidth: FlexColumnWidth(1.0),
                    columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(6.5),
                },
                    children: [
                  TableRow(children: [
                    TableCell(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.note,
                            // size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              alignment: Alignment.center,
                              //height: 150,
                              child: Text("Description: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ])),
                    TableCell(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            //height: 150,
                            child: Text(widget.house.description,
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ])),
            SizedBox(
              height: 10,
            ),
          ]))
        ]))));
  }

  _callPhone(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Make a phone call' + '?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                _makePhoneCall('tel:' + widget.house.contact);
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue[400],
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.blue[400],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _googleMap(BuildContext context) {
    double lat = double.parse(widget.house.latitude);
    double log = double.parse(widget.house.longitude);
    return Container(
      height: 250,
      width: 400,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, log),
          zoom: 12,
        ),
        markers: _markers.values.toSet(),
        mapType: MapType.normal,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
