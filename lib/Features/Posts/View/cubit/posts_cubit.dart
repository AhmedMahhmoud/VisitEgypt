import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  retrievePosts(List<QueryDocumentSnapshot> docs){
    try {
      emit(RetrievePostsLoadingState());
      retrievedPosts= postsRepository.retrieveAllPosts(docs);
      emit(RetrievePostsDoneState(retrievedPosts: retrievedPosts));
    } catch (e) {
      emit(RetrievePostsErrorState(errorMsg: e.toString()));
    }
  }

}
