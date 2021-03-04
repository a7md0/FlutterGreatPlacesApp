import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';

import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Place findById(String id) => _items.firstWhere((place) => place.id == id);

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation placeLocation,
  ) async {
    final streetName = await LocationHelper.getPlaceAddress(
      placeLocation.latitude,
      placeLocation.longitude,
    ).catchError((e) => 'No address');

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: placeLocation.copyWith(address: streetName),
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
