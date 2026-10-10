import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String text;

  Comment({
    required this.text,
  });
}

class Post {
  final String imagePath;
  final String caption;

  int likes;
  bool isLiked;

  List<Comment> comments;

  Post({
    required this.imagePath,
    required this.caption,
    this.likes = 0,
    this.isLiked = false,
    List<Comment>? comments,
  }) : comments = comments ?? [];
}

class PostProvider extends ChangeNotifier {
  final List<Post> _posts = [];

  List<Post> get posts => _posts;

  // ADD POST
  Future<void> addPost(Post post) async {
    // First show post in app
    _posts.insert(0, post);
    notifyListeners();

    // Then save post to Firestore
    try {
      final docRef =
      await FirebaseFirestore.instance.collection('posts').add({
        'imagePath': post.imagePath,
        'caption': post.caption,
        'likes': post.likes,
        'createdAt': FieldValue.serverTimestamp(),
      });

      debugPrint('🔥 POST SAVED TO FIRESTORE');
      debugPrint('🔥 DOCUMENT ID: ${docRef.id}');
      debugPrint('🔥 PATH: ${docRef.path}');
    } catch (e) {
      debugPrint('❌ FIRESTORE ERROR: $e');
    }
  }

  // LIKE / UNLIKE
  void toggleLike(Post post) {
    if (post.isLiked) {
      post.isLiked = false;
      post.likes--;
    } else {
      post.isLiked = true;
      post.likes++;
    }

    notifyListeners();
  }

  // ADD COMMENT
  void addComment(Post post, String text) {
    if (text.trim().isEmpty) return;

    post.comments.add(
      Comment(text: text.trim()),
    );

    notifyListeners();
  }

  // DELETE POST
  void deletePost(Post post) {
    _posts.remove(post);
    notifyListeners();
  }
}