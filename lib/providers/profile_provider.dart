import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "Sumandeep Kaur";
  String _bio = "Flutter Developer 💙";

  String? _imagePath;

  String get name => _name;
  String get bio => _bio;
  String? get imagePath => _imagePath;

  void updateProfile({
    required String name,
    required String bio,
  }) {
    _name = name;
    _bio = bio;
    notifyListeners();
  }

  void updateProfileImage(String path) {
    _imagePath = path;
    notifyListeners();
  }
}