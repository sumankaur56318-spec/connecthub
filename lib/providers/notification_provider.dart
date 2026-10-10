import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "Aman liked your post ❤️",
      subtitle: "2 min ago",
      iconType: "like",
    ),
    NotificationModel(
      title: "Arshdeep started following you 👤",
      subtitle: "10 min ago",
      iconType: "follow",
    ),
    NotificationModel(
      title: "Simran commented: Nice Pic 🔥",
      subtitle: "30 min ago",
      iconType: "comment",
    ),
  ];

  void addNotification(NotificationModel notification) {
    notifications.insert(0, notification);
    notifyListeners();
  }
}