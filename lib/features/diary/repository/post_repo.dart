import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore;

  PostRepository(this._firestore);

  Future<void> addPost(Post post) async {
    try {
      await _firestore.collection('posts').add(post.toMap());
    } catch (e) {
      throw Exception('Error adding post: $e');
    }
  }

  Future<List<Post>> fetchPosts() async {
    try {
      final querySnapshot = await _firestore.collection('posts').get();
      return querySnapshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }
}
