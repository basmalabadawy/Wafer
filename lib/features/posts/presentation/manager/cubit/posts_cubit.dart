import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/features/posts/data/repos/posts_repo.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo _postsRepo = PostsRepo();

  PostsCubit() : super(PostsInitial());

  Future<void> getPosts({int? status}) async {
    emit(PostsLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getInt('accountType');

      final posts = role == 0
          ? await _postsRepo.getCharityPosts(status: status)
          : await _postsRepo.getPublicPosts();

      emit(PostsSuccess(posts));
    } catch (e) {
      emit(PostsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> fulfillPost(String id) async {
    try {
      await _postsRepo.fulfillPost(id);
      getPosts();
    } catch (e) {
      emit(PostsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> applyToPost(String id) async {
    try {
      await _postsRepo.applyToPost(id);
      emit(PostsApplySuccess());
    } catch (e) {
      emit(PostsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
