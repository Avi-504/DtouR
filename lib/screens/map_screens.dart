import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/select-places';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Map _pickedLocation;
  var _pickedLocationText;
  // Future getLocationWithNominatim() async {
  //   Map result = await showDialog(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return NominatimLocationPicker(
  //           searchHint: 'Search a place',
  //           awaitingForLocation: "Getting Your Location",
  //         );
  //       });
  //   if (result != null) {
  //     setState(() => _pickedLocation = result);
  //   } else {
  //     return;
  //   }
  // }

  // RaisedButton nominatimButton(Color color, String name) {
  //   return RaisedButton(
  //     color: color,
  //     onPressed: () async {
  //       await getLocationWithNominatim();
  //     },
  //     textColor: Colors.white,
  //     child: Center(
  //       child: Text(
  //         name,
  //         softWrap: true,
  //       ),
  //     ),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //   );
  // }

  Container mapBoxButton(Color color, String name) {
    return Container(
      margin: EdgeInsets.all(15),
      child: RaisedButton(
        color: color,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => getLocationWithMapBox()),
          );
        },
        textColor: Colors.white,
        child: Center(
          child: Text(
            name,
            softWrap: true,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  Widget getLocationWithMapBox() {
    return MapBoxLocationPicker(
      popOnSelect: true,
      apiKey:
          "pk.eyJ1IjoicnZmcmVha3MwMDciLCJhIjoiY2tjdWNpNndvMWQ1bjJxcGRlbGJtYTVleCJ9.x6q5bOfaOLFc01b6SHUr8w",
      limit: 15,
      language: 'en',
      // country: 'br',
      searchHint: 'Search Your Place',
      awaitingForLocation: "Getting Your Location",
      onSelected: (place) {
        setState(() {
          _pickedLocationText = place.geometry
              .coordinates; // Example of how to call the coordinates after using the Mapbox Location Picker
        });
      },
      context: context,
      customMapLayer: TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select A Map Provider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _pickedLocationText != null
              ? Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).accentColor,
                  ),
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Center(
                    child: GestureDetector(
                        child: Text(
                          "Submit Location",
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Theme.of(context).accentColor,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop({
                            'data': _pickedLocationText,
                            'MapPicker': 'MapBox'
                          });
                        }),
                  ),
                )
              : mapBoxButton(Colors.green, 'MapBox Location Picker'),
        ],
      ),
    );
  }
}
