import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/features/home/data/model/post.dto.dart';
import 'package:{{project_name.snakeCase()}}/features/home/data/repository/post_repository.dart';
import 'package:{{project_name.snakeCase()}}/features/home/data/service/post_service.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/model/post.dart';

import '../../../../utils/test_utils.dart';
import 'post_repository_test.mocks.dart';

@GenerateMocks(<Type>[PostService])
void main() {
  late MockPostService postService;
  late PostRepository postRepository;
  late PostDTO postDTO;

  setUp(() {
    postService = MockPostService();
    postRepository = PostRepository(postService);
    postDTO = PostDTO(
      uid: '1',
      title: 'title',
      author: 'author',
      permalink: 'permalink',
      createdUtc: DateTime.now(),
    );
  });

  group('Get Posts', () {
    test(
      'should return a list of posts',
      () async {
        // arrange
        final Map<String, dynamic> data = <String, dynamic>{
          'data': <String, dynamic>{
            'children': <Map<String, dynamic>>[
              <String, dynamic>{
                'data': postDTO.toJson(),
              },
            ],
          },
        };
        when(postService.getPosts()).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 200),
        );
        // act
        final Either<Failure, List<Post>> result =
            await postRepository.getPosts();
        // assert
        expect(result.isRight(), true);
      },
    );
    test(
      'should return a failure when list has an invalid post',
      () async {
        // arrange
        final Map<String, dynamic> data = <String, dynamic>{
          'data': <String, dynamic>{
            'children': <Map<String, dynamic>>[
              <String, dynamic>{
                'data': postDTO.copyWith(comments: -1).toJson(),
              },
            ],
          },
        };
        when(postService.getPosts()).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 200),
        );
        // act
        final Either<Failure, List<Post>> result =
            await postRepository.getPosts();
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when a server error occurs',
      () async {
        // arrange
        final Map<String, dynamic> data = <String, dynamic>{
          'data': <String, dynamic>{
            'children': <Map<String, dynamic>>[
              <String, dynamic>{
                'data': postDTO.toJson(),
              },
            ],
          },
        };
        when(postService.getPosts()).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 500),
        );
        // act
        final Either<Failure, List<Post>> result =
            await postRepository.getPosts();
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an unexpected error occurs',
      () async {
        // arrange
        when(postService.getPosts()).thenThrow(throwsException);
        // act
        final Either<Failure, List<Post>> result =
            await postRepository.getPosts();
        // assert
        expect(result.isLeft(), true);
      },
    );
  });
}
