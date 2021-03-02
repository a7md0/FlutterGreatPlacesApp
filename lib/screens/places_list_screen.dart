import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<GreatPlaces>(
            child: Center(
              child: const Text('No places yet, start adding some!'),
            ),
            builder: (ctx, greatPlaces, child) {
              if (greatPlaces.items.length == 0) {
                return child;
              }

              return ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, idx) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[idx].image),
                  ),
                  title: Text(greatPlaces.items[idx].title),
                  onTap: () {
                    // TODO: Details page
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
