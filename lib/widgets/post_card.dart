import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(
              "Sumandeep",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Just now"),
          ),

          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.file(
              File(post.imagePath),
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 80,
                    ),
                  ),
                );
              },
            ),
          ),

Row(
children: [
// LIKE BUTTON
IconButton(
onPressed: () {
provider.toggleLike(post);
},
icon: Icon(
post.isLiked
? Icons.favorite
: Icons.favorite_border,
color: post.isLiked ? Colors.red : Colors.black,
),
),

// COMMENT BUTTON
IconButton(
onPressed: () {
showModalBottomSheet(
context: context,
isScrollControlled: true,
builder: (_) {
final controller = TextEditingController();

return Padding(
padding: EdgeInsets.only(
left: 15,
right: 15,
top: 15,
bottom:
MediaQuery.of(context).viewInsets.bottom + 15,
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Text(
"Comments",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Expanded(
child: post.comments.isEmpty
? const Center(
child: Text("No Comments Yet 😊"),
)
: ListView.builder(
itemCount: post.comments.length,
itemBuilder: (context, index) {
return ListTile(
leading: const CircleAvatar(
child: Icon(Icons.person),
),
title: Text(
post.comments[index].text,
),
);
},
),
),

TextField(
controller: controller,
decoration: InputDecoration(
hintText: "Write a comment...",
border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(12),
),
suffixIcon: IconButton(
icon: const Icon(Icons.send),
onPressed: () {
provider.addComment(
post,
controller.text,
);

Navigator.pop(context);
},
),
),
),
],
),
);
},
);
},
icon: const Icon(Icons.comment_outlined),
),

// SHARE BUTTON
IconButton(
onPressed: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Post Shared 🎉"),
),
);
},
icon: const Icon(Icons.share),
),
],
),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${post.likes} Likes",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${post.comments.length} Comments",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              post.caption,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}