import 'package:flutter/foundation.dart';
import 'package:nativefeatures_app/helpers/location_helper.dart';
import 'dart:io';
import 'package:nativefeatures_app/model/place_model.dart';
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> addPlaces(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getAddresses(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    Place newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                  latitude: item['loc_lat'],
                  longitude: item['loc_lng'],
                  address: item['address']),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> removeItem(String placeId) async {
    _places.remove(placeId);
    await DBHelper.delete('user_places', placeId);
    notifyListeners();
  }
}
