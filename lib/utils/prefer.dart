// ignore_for_file: avoid_print, constant_identifier_names


import '../../main.dart';
import 'dart:convert';

class Prefs {
  static const String USER_ID = 'userId';
  static const String storeId = 'storeId';
  static const String KEY_TOKEN = 'TOKEN';
  static const String Attendance_Id = 'Attendance_Id';
  static const String BASE_URL = 'base_url';
  static const String IS_CHECK_IN = 'is_check_in';
  static const List<String> userRole = [];

  static setString(String key, String value) {
    return getStorage!.write(key, value);
  }

  static getString(String key) {
    return getStorage!.read(key) ?? '';
  }


  static setBool(String key, bool value) {
    return getStorage!.write(key, value);
  }

  static bool getBool(String key) {
    return getStorage!.read(key) ?? false;
  }

  static String getBaseUrl() {
    return getStorage!.read(BASE_URL) ?? '';
  }

  static setBaseUrl(String baseUrl) {
    return getStorage!.write(BASE_URL, baseUrl);
  }


  static String getToken() {
    return getStorage!.read(KEY_TOKEN) ?? '';
  }

  static setToken(String token) {
    return getStorage!.write(KEY_TOKEN, token);
  }

  static String getUserID() {
    return getStorage!.read(USER_ID) ?? '';
  }

  static setUserID(String userID) {
    return getStorage!.write(USER_ID, userID);
  }

  static String getStoreID() {
    return getStorage!.read(storeId) ?? '';
  }

  static setStoreID(String userID) {
    return getStorage!.write(storeId, userID);
  }

  static remove(String key) {
    return getStorage!.remove(key);
  }


  // Method to retrieve a list of strings
  // static List<String> getList(String key,List<String> key1) {
  //   String? encoded = getStorage!.read(key);
  //   if (encoded != null && encoded.isNotEmpty) {
  //     List<dynamic> decoded = json.decode(encoded);  // Decode JSON string into List
  //     return key1=List<String>.from(decoded); // Convert dynamic list to List<String>
  //   }
  //   return [];
  // }
  // static List<String> getRole(List<String> key) {
  //   // String? encoded = getStorage!.read(key);
  //   String role = "role";
  //   String encoded = json.encode(key); // Convert list to JSON string
  //   getStorage!.write(role, encoded);
  //   if (encoded != null && encoded.isNotEmpty) {
  //     List<dynamic> decoded = json.decode(encoded);
  //     print("user=============${List<String>.from(decoded)}");// Decode JSON string into List
  //     return List<String>.from(decoded); // Convert dynamic list to List<String>
  //   }
  //   return [];
  // }
  static List<String> setRole(String key, List<String> rolesToAdd) {
    // Retrieve the existing roles from storage or initialize to the default constant list
    List<String> existingRoles = List<String>.from(getStorage!.read(key) ?? userRole);

    // Add new roles
    existingRoles.addAll(rolesToAdd);

    // Save the updated list back to storage
    getStorage!.write(key, existingRoles);

    // Return the updated list
    return existingRoles;
  }

  static List<String> getRole(String key) {
    // Retrieve the list from storage, or return the default constant list
    return List<String>.from(getStorage!.read(key) ?? userRole);
  }

  static clear() {
    return getStorage!.erase();
  }
}
