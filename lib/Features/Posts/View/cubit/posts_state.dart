part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {}

class PostsErrorState extends PostsState {
  final String errorMsg;
  const PostsErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
