import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service class for managing storage of background color.
class StorageService {
  static const String _backgroundColorKey = 'background_color';

  /// Loads the saved background color from SharedPreferences.
  Future<Color> loadSavedColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? savedColor = prefs.getInt(_backgroundColorKey);
    return savedColor != null ? Color(savedColor) : Colors.white;
  }

  /// Saves the background color to SharedPreferences.
  Future<void> saveColor(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_backgroundColorKey, color.toARGB32());
  }
}
