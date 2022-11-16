import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../Logic/posts_repository.dart';
import '../../Model/posts_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {


  List<Posts> retrievedPosts=[];

  final PostsRepository postsRepository;
  PostsCubit({required this.postsRepository}) : super(PostsInitial());

  uploadPostImages(Posts post) async {
    try {
      emit(PostsLoadingState());
      await postsRepository.addNewPost(post);
      emit(PostsLoadedState());
    } catch (e) {
      emit(PostsErrorState(errorMsg: e.toString()));
    }
  }

/*
  retrievePosts(){

  }
*/




}
