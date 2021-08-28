import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:io' show Platform;
class MapSample extends StatefulWidget {
  double lat;
  double lng;
  MapSample({this.lat,this.lng});
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _mapController = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
   CameraPosition _initialCamera ;
   GoogleMapController map_controller;
  Position _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _getCurrentLocation();
    _initialCamera = CameraPosition(
      target: LatLng(widget.lat??  24.723201041398024,widget.lng?? 46.67196272469909),
      zoom: 5,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Container(
        width: width,
        height: height * .44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(height * .05),
                topLeft: Radius.circular(height * .05)),
            color: backgroundColor),
    child:Container(
        width: width,
        height: height * .44,
        child:  Stack(
          children: <Widget>[
            // Map View
            Stack(
              children: <Widget>[

                GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      map_controller = controller;
                      _mapController.complete(controller);
                    },
                    markers: Set<Marker>.of(markers.values),
                    circles: Set.from([
                      Circle(
                          circleId: CircleId("1"),
                          center: LatLng(26.5535015, 31.6981691),
                          radius: 5000,
                          fillColor: Colors.grey.withOpacity(.4),
                          strokeWidth: 0,
                          visible: true)
                    ]),

                    initialCameraPosition: _initialCamera,
                    padding: EdgeInsets.only(top: width * 0.001,),
                    mapType: MapType.normal,
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    onTap: (latLng) async{
                      sharedPreferenceManager.writeData(CachingKey.MAPS_LAT, latLng.latitude);
                      sharedPreferenceManager.writeData(CachingKey.Maps_lang, latLng.longitude);
                      print('${latLng.latitude}, ${latLng.longitude}');
                      final coordinates = new Coordinates(
                          latLng.latitude, latLng.longitude);
                      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                      var address = addresses.first;
                      sharedPreferenceManager.writeData(CachingKey.MAP_ADDRESS, address.addressLine);
                      print("map 1");
                      _add(
                          lat: latLng.latitude,
                          lng: latLng.longitude,
                          address: address.addressLine
                      );
                      print("map 2");
                    }
                ),

                Positioned(
                    top: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      children: [
                        SearchMapPlaceWidget(
                          apiKey: Platform.isAndroid? 'AIzaSyBNHA55gWwGxCyxjlhKhdZ45Q1cAZBRz0M' : 'AIzaSyA19oV9fN9IDDaVpWJ4MJETCjG7QKpG9hE',
                          onSelected: (place) async {
                            print('place : ${await place.description}');
                            final geolocation = await place.geolocation;
                            print("locstion : ${geolocation.coordinates}");

                            map_controller = await _mapController.future;
                            map_controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                            map_controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                            print("---map latitude --- : ${geolocation.coordinates.latitude}");
                            print("--- map longitude --- : ${geolocation.coordinates.longitude}");
                            sharedPreferenceManager.writeData(CachingKey.MAPS_LAT, geolocation.coordinates.latitude);
                            sharedPreferenceManager.writeData(CachingKey.Maps_lang, geolocation.coordinates.longitude,);
                            final coordinates = new Coordinates(
                                geolocation.coordinates.latitude,  geolocation.coordinates.longitude);
                            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                            var address = addresses.first;
                            sharedPreferenceManager.writeData(CachingKey.MAP_ADDRESS, address.addressLine);
                            _add(
                                lat: geolocation.coordinates.latitude,
                                lng: geolocation.coordinates.longitude,
                                address: address.addressLine
                            );
                          },
                        ),

                      ],
                    )


                ),
              ],),
            // Show zoom buttons
            SafeArea(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:  EdgeInsets.only(right: 10.0,top: width * 0.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.add,color: greyColor,),
                              ),
                              onTap: () {
                                map_controller.animateCamera(
                                  CameraUpdate.zoomIn(),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.remove,color: greyColor,),
                              ),
                              onTap: () {
                                map_controller.animateCamera(
                                  CameraUpdate.zoomOut(),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),)
              ),
            ),
            // Show the place input fields & button for
            // showing the route
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:  EdgeInsets.only(right: 10.0, top: width * 0.3),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location,color: greyColor,),
                        ),
                        onTap: () {
                          map_controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),



    ));
  }


  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId("1"),
        center: LatLng(26.5535015, 31.6981691),
        radius: 5000,
        fillColor: Colors.grey.withOpacity(.4),
        strokeWidth: 0,
        visible: true)
  ]);
//  -------------------------------------------------------------------- (end of google maps functions part )

  void _add({double lat,double lng,String address}) {
    final MarkerId markerId = MarkerId('ezhyper');
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: MarkerId(address),
      infoWindow: InfoWindow(
        title:address,
      ),
      position: LatLng(
        lat ,
        lng,

      ),
      onTap: () {

      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  // Method for retrieving the current location
_getCurrentLocation() async {
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
    setState(() {
      print("position : ${position.longitude}");
      _currentPosition = position;
      print('CURRENT POS: $_currentPosition');
      map_controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
  }).catchError((e) {
    print(e);
  });
}
}