import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../screens/map_screens.dart';
import '../helpers/location_helper.dart';

class PlaceInput extends StatefulWidget {
  final Function onSelectPlace;
  PlaceInput(this.onSelectPlace);
  @override
  _PlaceInputState createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  String _previewImageUrl;

  Future<void> _getUserCurrentLocation() async {
    try {
      final locdata = await Location().getLocation();
      final previewUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locdata.latitude,
        longitude: locdata.longitude,
      );
      setState(() {
        _previewImageUrl = previewUrl;
        widget.onSelectPlace(locdata.latitude, locdata.longitude);
      });
    } catch (error) {
      return;
    }
  }

  Future<void> _selectLocationfromUser() async {
    final Map selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final longLat = selectedLocation['data'] as List<double>;
    final double longitude = longLat[0];
    final double latitude = longLat[1];
    final previewUrl = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImageUrl = previewUrl;
      widget.onSelectPlace(latitude, longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 200,
            width: double.infinity,
            child: _previewImageUrl == null
                ? Image(
                    image: AssetImage('assets/images/google-maps-india.png'),
                    fit: BoxFit.cover,
                    width: double.infinity)
                : Image.network(
                    _previewImageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getUserCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectLocationfromUser,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
