import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = '[YOR_API_KEY]';

class LocationHelper {
  static String generateLocationPreviesImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$latitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddresses(double latitude, double longitude) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    print(response.body);
    return json.decode(response.body)['results'][0]["formatted_address"];
  }
}
