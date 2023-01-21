part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    required List<Post> posts,
    required bool isLoading,
    required Failure? failure,
  }) = _PostState;

  factory PostState.initial() => const _PostState(
        posts: <Post>[],
        isLoading: false,
        failure: null,
      );
}
