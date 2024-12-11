import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/azkar_model.dart';
import '../utils/constants.dart';

class ApiService {
  static Future<List<Azkar>> fetchAzkar() async {
    final response = await http.get(Uri.parse("$BASE_URL/azkar/"));

    if (response.statusCode == 200) {
      // Explicitly decode the response as UTF-8
      String decodedBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(decodedBody);
      return data.map((json) => Azkar.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load Azkar");
    }
  }

  static Future<String> fetchDatabaseVersion() async {
    final response = await http.get(Uri.parse("$BASE_URL/db_version/"));
    if (response.statusCode == 200) {
      return json.decode(response.body)['version'];
    } else {
      throw Exception("Failed to fetch DB version");
    }
  }
}
