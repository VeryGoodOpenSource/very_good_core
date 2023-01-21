import 'package:dartz/dartz.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/model/post.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
}
