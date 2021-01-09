import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<LocationData> _getUserLocation;
  LatLng _markerLocation = new LatLng(6.4676929, 100.5067673);
  LatLng _userLocation;
  String _resultAddress;
  @override
  void initState() {
    super.initState();
    _getUserLocation = getUserLocation();
  }

  Future<LocationData> getUserLocation() async {
    Location location = new Location();

    final result = await location.getLocation();
    _userLocation = LatLng(result.latitude, result.longitude);
    return result;
  }

  getSetAddress(Coordinates coordinates) async {
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _resultAddress = addresses.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder<LocationData>(
                  future: _getUserLocation,
                  builder: (context, snapshot) {
                    switch (snapshot.hasData) {
                      case true:
                        return MyMap(
                          markerLocation: _markerLocation,
                          userLocation: _userLocation,
                          onTap: (location) {
                            setState(() {
                              _markerLocation = location;
                            });
                          },
                        );
                      default:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  _resultAddress ?? "Address will be shown here",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "Current Latitude:  " + _markerLocation.latitude.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  "Current Longtitude:  " +
                      _markerLocation.longitude.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("Get Marker's Address"),
                  onPressed: () async {
                    if (_markerLocation != null) {
                      getSetAddress(Coordinates(
                          _markerLocation.latitude, _markerLocation.longitude));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  final markerLocation, userLocation, onTap;

  const MyMap({Key key, this.markerLocation, this.userLocation, this.onTap})
      : super(key: key);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(6.4676929, 100.5067673), zoom: 17),
      mapType: MapType.hybrid,
      markers: widget.markerLocation != null
          ? [
              Marker(
                  markerId: MarkerId("Tap Location"),
                  position: widget.markerLocation),
            ].toSet()
          : null,
      onTap: widget.onTap,
    );
  }
}
