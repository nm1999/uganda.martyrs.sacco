import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefService {
  static const String _userId = 'user_id';
  static const String _firstName = 'first_name';
  static const String _surName = 'sur_name';
  static const String _contact = 'contact';
  static const String _jsonData = 'json_data';
  static const String _members = 'members';

  // Save user ID
  static Future<bool> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_userId, id);
  }

  // Get user ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId);
  }

  // Save first name
  static Future<bool> saveFirstName(String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_firstName, firstName);
  }

  // Get first name
  static Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_firstName);
  }

  // Save surname
  static Future<bool> saveSurName(String surName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_surName, surName);
  }

  // Get surname
  static Future<String?> getSurName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_surName);
  }

  // Save contact
  static Future<bool> saveContact(String contact) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_contact, contact);
  }

  // Get contact
  static Future<String?> getContact() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_contact);
  }

  // Save JSON data
  Future<bool> saveJsonData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    return prefs.setString(_jsonData, jsonString);
  }

  // Get JSON data
  static Future<Map<String, dynamic>?> getJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_jsonData);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  // Save members
  static Future<bool> saveMembers(List<Map<String, dynamic>> members) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(members);
    return prefs.setString(_members, jsonString);
  }

  // Get members
  static Future<List<Map<String, dynamic>>?> getMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_members);
    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<Map<String, dynamic>>();
    }
    return null;
  }

  // Clear all user data
  Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  // Clear specific key
  static Future<bool> clearKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
