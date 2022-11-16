part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class RetrievePostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {}


class RetrievePostsDoneState extends PostsState {
  final List<Posts> retrievedPosts;
  const RetrievePostsDoneState({required this.retrievedPosts});
  @override
  List<Object> get props => [retrievedPosts];
}

class PostsErrorState extends PostsState {
  final String errorMsg;
  const PostsErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
