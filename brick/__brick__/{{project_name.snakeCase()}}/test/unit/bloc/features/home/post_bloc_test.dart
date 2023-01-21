import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/interface/i_local_storage_repository.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/features/home/data/model/post.dto.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/bloc/post/post_bloc.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/interface/i_post_repository.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/model/post.dart';

import 'post_bloc_test.mocks.dart';

@GenerateMocks(<Type>[IPostRepository, ILocalStorageRepository])
void main() {
  late MockIPostRepository postRepository;
  late PostBloc postBloc;

  late Failure failure;
  List<Post> posts = <Post>[];

  setUp(() async {
    postRepository = MockIPostRepository();
    failure =
        const Failure.serverError(StatusCode.api500, 'INTERNAL SERVER ERROR');
    postBloc = PostBloc(postRepository);
    posts = <Post>[
      PostDTO(
        uid: '1',
        title: 'title',
        author: 'author',
        permalink: 'permalink',
        createdUtc: DateTime.now(),
      ).toDomain(),
    ];
  });

  group('PostBloc getPosts', () {
    blocTest<PostBloc, PostState>(
      'should emit a success state with list of posts',
      build: () {
        when(postRepository.getPosts()).thenAnswer((_) async => right(posts));

        return PostBloc(postRepository);
      },
      act: (PostBloc bloc) async => bloc.getPosts(),
      expect: () => <dynamic>[PostState.initial().copyWith(posts: posts)],
    );
    blocTest<PostBloc, PostState>(
      'should emit a failed state with posts from local storage ',
      build: () {
        when(postRepository.getPosts()).thenAnswer((_) async => left(failure));

        return PostBloc(postRepository);
      },
      act: (PostBloc bloc) async => bloc.getPosts(),
      expect: () =>
          <dynamic>[postBloc.state.copyWith(posts: <Post>[], failure: failure)],
    );

    blocTest<PostBloc, PostState>(
      'should emit a failed state with throwsException error ',
      build: () {
        when(postRepository.getPosts()).thenThrow(throwsException);

        return PostBloc(postRepository);
      },
      act: (PostBloc bloc) async => bloc.getPosts(),
      expect: () => <dynamic>[
        postBloc.state.copyWith(
          isLoading: true,
          failure: Failure.unexpected(throwsException.toString()),
        ),
        postBloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
  });
}
