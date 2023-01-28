import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:very_good_core/app/utils/converters.dart';
import 'package:very_good_core/app/utils/extensions.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/features/home/domain/model/post.dart';

part 'post.dto.freezed.dart';
part 'post.dto.g.dart';

@freezed
class PostDTO with _$PostDTO {
  const factory PostDTO({
    @JsonKey(name: 'id') required String uid,
    required String title,
    required String author,
    required String permalink,
    String? selftext,
    @JsonKey(name: 'created_utc')
    @TimestampToDateTime()
        required DateTime createdUtc,
    @JsonKey(name: 'link_flair_background_color')
        String? linkFlairBackgroundColor,
    @JsonKey(name: 'link_flair_text') String? linkFlairText,
    @JsonKey(name: 'ups', defaultValue: 0) int? upvotes,
    @JsonKey(name: 'num_comments', defaultValue: 0) int? comments,
    @JsonKey(name: 'url_overridden_by_dest') String? urlOverriddenByDest,
  }) = _PostDTO;

  const PostDTO._();

  factory PostDTO.fromJson(Map<String, dynamic> json) =>
      _$PostDTOFromJson(json);

  factory PostDTO.fromDomain(Post post) => PostDTO(
        uid: post.uid.getOrCrash(),
        title: post.title.getOrCrash(),
        author: post.author.getOrCrash(),
        permalink: post.permalink.getOrCrash(),
        selftext: post.selftext.getOrCrash(),
        createdUtc: post.createdUtc,
        linkFlairBackgroundColor:
            post.linkFlairBackgroundColor.toHex(hashSign: true),
        linkFlairText: post.linkFlairText.getOrCrash(),
        upvotes: post.upvotes.getOrCrash().toInt(),
        comments: post.comments.getOrCrash().toInt(),
        urlOverriddenByDest: post.urlOverriddenByDest?.getOrCrash(),
      );

  static List<PostDTO?>? postFromJson(String str) => json.decode(str) == null
      ? <PostDTO>[]
      : List<PostDTO?>.from(
          json.decode(str).map(PostDTO.fromJson),
        );

  static String postToJson(List<PostDTO?>? data) => json.encode(
        data == null
            ? <PostDTO>[]
            : List<dynamic>.from(data.map((PostDTO? x) => x!.toJson())),
      );

  Post toDomain() => Post(
        uid: UniqueId.fromUniqueString(uid),
        title: ValueString(
          HtmlUnescape().convert(title).replaceAll('&#x200B;', '\u2028'),
        ),
        author: ValueName(author),
        permalink: Url('https://www.reddit.com$permalink'),
        createdUtc: createdUtc,
        linkFlairBackgroundColor: linkFlairBackgroundColor.isNotNullOrBlank
            ? ColorX.fromHex(linkFlairBackgroundColor!)
            : Colors.transparent,
        upvotes: Number(upvotes ?? 0),
        comments: Number(comments ?? 0),
        selftext: ValueString(
          selftext.isNotNullOrBlank
              ? HtmlUnescape()
                  .convert(selftext!)
                  .replaceAll('&#x200B;', '\u2028')
              : '',
        ),
        linkFlairText: ValueString(linkFlairText),
        urlOverriddenByDest: urlOverriddenByDest.isNotNullOrBlank
            ? Url(urlOverriddenByDest!)
            : null,
      );
}
