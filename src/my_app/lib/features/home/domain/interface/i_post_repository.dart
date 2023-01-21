import 'package:dartz/dartz.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/features/home/domain/model/post.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
}
