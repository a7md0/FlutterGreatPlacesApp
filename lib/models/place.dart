import 'dart:io';

import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        location = PlaceLocation.fromJson(json),
        image = File(json['image']);

  Place copyWith({
    String id,
    String title,
    PlaceLocation location,
    File image,
  }) =>
      Place(
        id: id ?? this.id,
        title: title ?? this.title,
        location: location ?? this.location,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson({bool inline = false}) {
    Map<String, dynamic> json = {
      'id': id,
      'title': title,
      'image': image.path,
    };

    if (location != null) {
      if (inline) {
        json.addAll(location.toJson());
      } else {
        json['location'] = location.toJson();
      }
    }

    return json;
  }
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

  PlaceLocation.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'];

  PlaceLocation copyWith({
    double latitude,
    double longitude,
    String address,
  }) =>
      PlaceLocation(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };
}
