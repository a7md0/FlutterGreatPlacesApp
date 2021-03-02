import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';

import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _items.add(newPlace);

    notifyListeners();

    DatabaseHelper.insert('user_places', newPlace.toJson());
  }

  Future<void> fetchPlaces() async {
    final placesList = await DatabaseHelper.select('user_places');
    _items = placesList.map((item) => Place.fromJson(item)).toList();

    notifyListeners();
  }
}
