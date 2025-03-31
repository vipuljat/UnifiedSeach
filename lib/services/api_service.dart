import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> search(String query) async {
    final url = _getBackendUrl(query);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load search results: ${response.statusCode}');
    }
  }

  static String _getBackendUrl(String query) {
    const String emulatorUrl = 'http://10.0.2.2:8000/search?q=';
    const String webUrl = 'http://localhost:8000/search?q=';
    const String physicalDeviceUrl = 'http://192.168.226.73:8000/search?q=';

    if (Uri.base.host.contains('10.0.2.2')) {
      return emulatorUrl + Uri.encodeComponent(query);
    } else if (Uri.base.host.contains('localhost')) {
      return webUrl + Uri.encodeComponent(query);
    } else {
      return physicalDeviceUrl + Uri.encodeComponent(query);
    }
  }
}