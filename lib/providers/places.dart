import 'dart:io';
import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_long': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchNsavePlace() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList
        .map((place) => Place(
              id: place['id'],
              image: File(place['image']),
              location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_long'],
                address: place['address'],
              ),
              title: place['title'],
            ))
        .toList();
    notifyListeners();
  }
}
