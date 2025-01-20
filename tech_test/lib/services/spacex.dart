import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tech_test/models/launch.dart';
import 'package:tech_test/models/mission.dart';

class SpaceXService {
  // Base URL for SpaceX API
  static const String _baseUrl = 'https://api.spacexdata.com/v3';

  // Fetch all launches
  Future<List<Launch>> getLaunches({int limit = 10, int offset = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/launches?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Launch.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load launches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch launches: $e');
    }
  }

  // Fetch launch by flight number
  Future<Launch> getLaunchByFlightNumber(int flightNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/launches/$flightNumber'),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Launch.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load launch details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch launch details: $e');
    }
  }

  // Fetch all missions
  Future<List<Mission>> getMissions() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/missions'));

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Mission.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load missions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch missions: $e');
    }
  }

  // Fetch mission by ID
  Future<Mission> getMissionById(String missionId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/missions/$missionId'));

      if (response.statusCode == HttpStatus.ok) {
        return Mission.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load mission details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch mission details: $e');
    }
  }
}