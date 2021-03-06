import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/places.dart';
import './screens/places_list_screen.dart';
import './screens/add_places_screen.dart';
import './screens/place_detail_screen.dart';
// import './screens/map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'DtouR',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlacesScreen.routeName: (ctx) => AddPlacesScreen(),
          // MapScreen.routeName: (ctx) => MapScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
