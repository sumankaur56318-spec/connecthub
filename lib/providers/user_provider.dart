import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final List<UserModel> users = [
    UserModel(
      name: "Sumandeep Kaur",
      username: "@sumandeep",
      image: "https://i.pravatar.cc/150?img=1",
    ),
    UserModel(
      name: "Aman Singh",
      username: "@aman",
      image: "https://i.pravatar.cc/150?img=2",
    ),
    UserModel(
      name: "Simran Kaur",
      username: "@simran",
      image: "https://i.pravatar.cc/150?img=3",
    ),
    UserModel(
      name: "Karan",
      username: "@karan",
      image: "https://i.pravatar.cc/150?img=4",
    ),
    UserModel(
      name: "Harpreet",
      username: "@harpreet",
      image: "https://i.pravatar.cc/150?img=5",
    ),
    UserModel(
      name: "Arshdeep",
      username: "@arsh",
      image: "https://i.pravatar.cc/150?img=6",
    ),
    UserModel(
      name: "Gurpreet",
      username: "@gurpreet",
      image: "https://i.pravatar.cc/150?img=7",
    ),
    UserModel(
      name: "Jaspreet",
      username: "@jaspreet",
      image: "https://i.pravatar.cc/150?img=8",
    ),
  ];

  void toggleFollow(UserModel user) {
    user.isFollowing = !user.isFollowing;

    if (user.isFollowing) {
      user.followers++;
    } else {
      user.followers--;
    }

    notifyListeners();
  }
}