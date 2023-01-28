import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:very_good_core/app/constants/route.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_text_url.dart';
import 'package:very_good_core/features/home/domain/model/post.dart';
import 'package:very_good_core/features/home/presentation/widgets/post_container_footer.dart';
import 'package:very_good_core/features/home/presentation/widgets/post_container_header.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.sm),
        child: GestureDetector(
          onTap: () => launchPostDetails(context),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(Insets.xs),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PostContainerHeader(post: post),
                  if (post.urlOverriddenByDest != null)
                    Padding(
                      padding: EdgeInsets.all(Insets.med),
                      child: VeryGoodCoreTextUrl(
                        url: post.urlOverriddenByDest!,
                        onTap: () => launchUrl(
                          Uri.parse(
                            post.urlOverriddenByDest!.getOrCrash(),
                          ),
                        ),
                      ),
                    ),
                  if (post.selftext.getOrCrash().isNotNullOrBlank)
                    Flexible(
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor.withOpacity(0),
                            ],
                          ),
                        ),
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: IgnorePointer(
                          child: Markdown(
                            data: post.selftext.getOrCrash(),
                            styleSheet:
                                MarkdownStyleSheet(p: AppTextStyle.bodyMedium),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),
                        ),
                      ),
                    ),
                  PostContainerFooter(post: post),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> launchPostDetails(BuildContext context) async {
    if (kIsWeb) {
      await launchUrl(
        Uri.parse(post.permalink.getOrCrash()),
        webOnlyWindowName: '_blank',
      );
    } else {
      GoRouter.of(context).pushNamed(
        RouteName.postDetails.name,
        params: <String, String>{'postId': post.uid.getOrCrash()},
        extra: post,
      );
    }
  }
}
