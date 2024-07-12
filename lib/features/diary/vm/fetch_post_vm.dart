import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:flutter_senior_project/features/diary/repository/post_repo.dart';

final postRepositoryProvider =
    Provider((ref) => PostRepository(FirebaseFirestore.instance));

final fetchPostsViewModelProvider =
    StateNotifierProvider<FetchPostsViewModel, AsyncValue<List<Post>>>((ref) {
  return FetchPostsViewModel(ref.read(postRepositoryProvider));
});

class FetchPostsViewModel extends StateNotifier<AsyncValue<List<Post>>> {
  final PostRepository _postRepository;

  FetchPostsViewModel(this._postRepository) : super(const AsyncValue.loading());

  Future<void> fetchPosts() async {
    try {
      final posts = await _postRepository.fetchPosts();
      state = AsyncValue.data(posts);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
