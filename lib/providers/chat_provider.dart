import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatModel> _messages = [
    ChatModel(
      text: "Hello 👋",
      image: null,
      time: "10:24 AM",
      isMe: false,
    ),
  ];

  List<ChatModel> get messages => _messages;

  String _currentTime() {
    final now = DateTime.now();

    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);

    final minute = now.minute.toString().padLeft(2, '0');

    final period = now.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _messages.add(
      ChatModel(
        text: text.trim(),
        image: null,
        time: _currentTime(),
        isMe: true,
      ),
    );

    notifyListeners();
  }

  void sendImage(String imagePath) {
    _messages.add(
      ChatModel(
        text: "",
        image: imagePath,
        time: _currentTime(),
        isMe: true,
      ),
    );

    notifyListeners();
  }
}