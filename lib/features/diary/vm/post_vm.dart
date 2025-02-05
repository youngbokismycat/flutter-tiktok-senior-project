import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:flutter_senior_project/features/diary/repository/post_repo.dart';

final postRepositoryProvider =
    Provider((ref) => PostRepository(FirebaseFirestore.instance));

final addPostViewModelProvider =
    StateNotifierProvider<AddPostViewModel, AsyncValue<void>>((ref) {
  return AddPostViewModel(ref.read(postRepositoryProvider));
});

class AddPostViewModel extends StateNotifier<AsyncValue<void>> {
  final PostRepository _postRepository;

  AddPostViewModel(this._postRepository) : super(const AsyncValue.data(null));

  Future<void> addPost(Post post) async {
    state = const AsyncValue.loading();
    try {
      await _postRepository.addPost(post);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
