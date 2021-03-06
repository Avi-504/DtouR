import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import './add_places_screen.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchNsavePlace(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: const Text('No Places Added Yet,Try adding Some'),
                ),
                builder: (context, places, child) => places.places.length <= 0
                    ? child
                    : GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: places.places.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, index) => GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: places.places[index].id),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GridTile(
                              child: Image(
                                image: FileImage(places.places[index].image),
                                fit: BoxFit.cover,
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.black54,
                                title: Row(
                                  children: <Widget>[
                                    Text(places.places[index].title),
                                  ],
                                ),
                                subtitle:
                                    Text(places.places[index].location.address),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
