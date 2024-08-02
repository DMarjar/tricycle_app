import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tricycle_app/models/tricycle_save.dart';
import '../models/tricycle.dart';
import '../api_config.dart';

class TricycleRepository {
  // Get all tricycles
  Future<List<Tricycle>> getAllTricycles() async {
    try {
      final response = await http.get(Uri.parse(getAllTricyclesUrl));
      if (response.statusCode == 200) {
        final List<dynamic> tricyclesJson = jsonDecode(response.body);
        return tricyclesJson.map((json) => Tricycle.fromJson(json)).toList();
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception("Failed to load tricycles $e");
    }
  }

  // Save a tricycle
  Future<void> saveTricycle(TricycleSave tricycle) async {
    try {
      final response = await http.post(
        Uri.parse(saveTricycleUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(tricycle.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception("Failed to save tricycle $e");
    }
  }

  // Update a tricycle
  Future<void> updateTricycle(Tricycle tricycle) async {
    try {
      final response = await http.put(
        Uri.parse(updateTricycleUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(tricycle.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception("Failed to update tricycle $e");
    }
  }

  // Delete a tricycle
  Future<void> deleteTricycle(int id) async {
    try {
      final response = await http.post(
        Uri.parse(deleteTricycleUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception("Failed to delete tricycle $e");
    }
  }
}
