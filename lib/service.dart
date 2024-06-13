import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'YOUR_OPENWEATHERMAP_API_KEY';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<String> fetchWeather(double lat, double lon) async {
    final response = await http.get(
        Uri.parse('$apiUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData['weather'][0]['description'];
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
