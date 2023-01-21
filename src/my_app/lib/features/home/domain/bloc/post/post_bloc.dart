import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/features/home/domain/interface/i_post_repository.dart';
import 'package:very_good_core/features/home/domain/model/post.dart';

part 'post_bloc.freezed.dart';
part 'post_state.dart';

@injectable
class PostBloc extends Cubit<PostState> {
  PostBloc(
    this._postRepository,
  ) : super(PostState.initial()) {
    initialize();
  }

  final IPostRepository _postRepository;

  Future<void> initialize() async {
    await getPosts();
  }

  Future<void> getPosts() async {
    try {
      emit(state.copyWith(isLoading: true));

      final Either<Failure, List<Post>> possibleFailure =
          await _postRepository.getPosts();
      emit(
        possibleFailure.fold(
          (Failure failure) =>
              state.copyWith(isLoading: false, failure: failure),
          (List<Post> posts) => state.copyWith(isLoading: false, posts: posts),
        ),
      );
    } catch (error) {
      log(error.toString());

      emit(
        state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(error.toString()),
        ),
      );
    }
  }
}
