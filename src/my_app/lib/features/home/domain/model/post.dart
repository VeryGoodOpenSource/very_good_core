import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required UniqueId uid,
    required ValueString title,
    required ValueName author,
    required Url permalink,
    required DateTime createdUtc,
    required Color linkFlairBackgroundColor,
    required Number upvotes,
    required Number comments,
    required ValueString selftext,
    required ValueString linkFlairText,
    required Url? urlOverriddenByDest,
  }) = _Post;

  const Post._();

  Option<Failure> get failureOption => uid.failureOrUnit
      .andThen(author.failureOrUnit)
      .andThen(permalink.failureOrUnit)
      .andThen(upvotes.failureOrUnit)
      .andThen(comments.failureOrUnit)
      .andThen(urlOverriddenByDest?.failureOrUnit ?? right(unit))
      .fold(some, (_) => none());
}
