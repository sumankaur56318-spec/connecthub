import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String name;

  const ChatScreen({
    super.key,
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
final TextEditingController controller = TextEditingController();

final ImagePicker picker = ImagePicker();

Future<void> pickFromGallery() async {
final XFile? image = await picker.pickImage(
source: ImageSource.gallery,
);

if (image != null) {
Provider.of<ChatProvider>(
context,
listen: false,
).sendImage(image.path);
}
}

Future<void> pickFromCamera() async {
final XFile? image = await picker.pickImage(
source: ImageSource.camera,
);

if (image != null) {
Provider.of<ChatProvider>(
context,
listen: false,
).sendImage(image.path);
}
}

@override
Widget build(BuildContext context) {
final provider = Provider.of<ChatProvider>(context);

return Scaffold(
appBar: AppBar(
title: Text(widget.name),
actions: const [
Icon(Icons.call),
SizedBox(width: 15),
Icon(Icons.videocam),
SizedBox(width: 10),
],
),

body: Column(
children: [
Expanded(
child: ListView.builder(
padding: const EdgeInsets.all(12),
itemCount: provider.messages.length,
itemBuilder: (context, index) {
final message = provider.messages[index];

return Align(
alignment: message.isMe
? Alignment.centerRight
: Alignment.centerLeft,
child: Container(
margin: const EdgeInsets.symmetric(vertical: 5),
padding: const EdgeInsets.all(12),
constraints: const BoxConstraints(
maxWidth: 280,
),
decoration: BoxDecoration(
color: message.isMe
? Colors.blue
: Colors.grey.shade300,
borderRadius: BorderRadius.circular(15),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [

if (message.image != null)
ClipRRect(
borderRadius: BorderRadius.circular(10),
child: Image.file(
File(message.image!),
height: 220,
width: 220,
fit: BoxFit.cover,
),
),

if (message.text.isNotEmpty) ...[
Text(
message.text,
style: TextStyle(
color: message.isMe
? Colors.white
: Colors.black,
),
),
const SizedBox(height: 5),
],

Row(
mainAxisSize: MainAxisSize.min,
children: [
Text(
message.time,
style: TextStyle(
fontSize: 10,
color: message.isMe
? Colors.white70
: Colors.black54,
),
),

if (message.isMe) ...[
const SizedBox(width: 4),
const Icon(
Icons.done_all,
size: 14,
color: Colors.white70,
),
],
],
),
],
),
),
);
},
),
),
  SafeArea(
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Row(
        children: [

          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            onPressed: () {},
          ),

          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: pickFromGallery,
          ),

          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: pickFromCamera,
          ),

          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () {
                provider.sendMessage(controller.text);
                controller.clear();
              },
            ),
          ),
        ],
      ),
    ),
  ),
],
),
);
}
}