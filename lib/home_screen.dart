import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/post_provider.dart';
import 'widgets/post_card.dart';
import 'notification_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ConnectHub",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          // Notification Button
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationScreen(),
                ),
              );
            },
          ),

          // Message Button
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(
                    name: "ConnectHub Chat",
                  ),
                ),
              );
            },
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: postProvider.posts.isEmpty
          ? const Center(
        child: Text(
          "No Posts Yet 📷\nCreate your first post!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          return PostCard(
            post: postProvider.posts[index],
          );
        },
      ),
    );
  }
}