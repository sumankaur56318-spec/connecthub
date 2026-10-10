class ChatModel {
  final String text;
  final String? image;
  final String time;
  final bool isMe;

  ChatModel({
    required this.text,
    this.image,
    required this.time,
    required this.isMe,
  });
}