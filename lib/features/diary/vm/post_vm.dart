import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';

class PostViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPost(Post post) async {
    try {
      await _firestore.collection('posts').add(post.toMap());
    } catch (e) {
      // Handle any errors here
      print('Error adding post: $e');
    }
  }
}
