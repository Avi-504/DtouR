import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/url-https%3A%2F%2Fwww.mapbox.com%2Fimg%2Frocket.png($longitude,$latitude)/$longitude,$latitude,17/1000x1000?access_token=pk.eyJ1IjoicnZmcmVha3MwMDciLCJhIjoiY2tjdWNpNndvMWQ1bjJxcGRlbGJtYTVleCJ9.x6q5bOfaOLFc01b6SHUr8w";
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url =
        'https://nominatim.openstreetmap.org/search?q=$lat+$long&format=json&addressdetails=1';
    final response = await http.get(url);
    final responseData = json.decode(response.body) as List<dynamic>;
    final addressResponse = responseData[0];
    final address = addressResponse['display_name'];
    return address;
  }
}
