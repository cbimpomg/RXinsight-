import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/drug.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<List<Drug>> fetchDrugs() async {
    // TODO: Replace with actual API endpoint
    final response = await http.get(Uri.parse('https://api.example.com/drugs'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Drug.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load drugs');
    }
  }
}
