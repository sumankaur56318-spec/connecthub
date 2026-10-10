import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/notification_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: provider.notifications.length,
        itemBuilder: (context, index) {
          final notification = provider.notifications[index];

          IconData icon;
          Color color;

          switch (notification.iconType) {
            case "like":
              icon = Icons.favorite;
              color = Colors.red;
              break;

            case "follow":
              icon = Icons.person_add;
              color = Colors.blue;
              break;

            case "comment":
              icon = Icons.comment;
              color = Colors.green;
              break;

            default:
              icon = Icons.notifications;
              color = Colors.grey;
          }

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color),
              ),
              title: Text(
                notification.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(notification.subtitle),
            ),
          );
        },
      ),
    );
  }
}