import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../helpers/location_helper.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<Places>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Image(
                image: FileImage(selectedPlace.image),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 200,
              width: double.infinity,
              child: Image.network(
                LocationHelper.generateLocationPreviewImage(
                  latitude: selectedPlace.location.latitude,
                  longitude: selectedPlace.location.longitude,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    selectedPlace.location.address,
                    softWrap: true,
                    style: TextStyle(
                      backgroundColor: Colors.amber,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
