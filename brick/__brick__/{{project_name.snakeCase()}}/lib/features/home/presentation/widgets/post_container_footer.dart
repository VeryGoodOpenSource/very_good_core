import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_theme.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/spacing.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/text_styles.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/extensions.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/model/post.dart';

class PostContainerFooter extends StatelessWidget {
  const PostContainerFooter({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          _FooterItems(
            leftIcon: Icons.arrow_upward_rounded,
            rightIcon: Icons.arrow_downward_rounded,
            value: post.upvotes.getOrCrash() == 0
                ? context.l10n.post__upvotes_default_value__vote
                : post.upvotes.getOrCrash().toString(),
          ),
          _FooterItems(
            leftIcon: Icons.chat_bubble_outline,
            value: post.comments.getOrCrash().toString(),
          ),
        ],
      );
}

class _FooterItems extends StatelessWidget {
  const _FooterItems({
    required this.leftIcon,
    required this.value,
    this.rightIcon,
  });

  final IconData leftIcon;
  final IconData? rightIcon;

  final String value;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: Insets.xxs),
        padding: EdgeInsets.symmetric(horizontal: Insets.xs),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
          ),
          borderRadius: AppTheme.defaultBoardRadius,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              leftIcon,
              size: (AppTextStyle.caption.fontSize ?? 14) * 1.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            Padding(
              padding: EdgeInsets.all(Insets.xs),
              child: Text(
                value,
                style: AppTextStyle.caption.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ),
            if (rightIcon != null)
              Icon(
                rightIcon,
                size: (AppTextStyle.caption.fontSize ?? 14) * 1.5,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
          ],
        ),
      );
}
