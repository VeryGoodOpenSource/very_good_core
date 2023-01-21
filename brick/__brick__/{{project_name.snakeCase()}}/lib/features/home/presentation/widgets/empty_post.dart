import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/spacing.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/text_styles.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/extensions.dart';

class EmptyPost extends StatelessWidget {
  const EmptyPost({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.list_alt,
              size: 200,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Insets.xs, top: Insets.sm),
              child: Text(
                context.l10n.post__empty_post__empty_post_message,
                textAlign: TextAlign.center,
                style: AppTextStyle.headline6.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.25),
                ),
              ),
            ),
          ],
        ),
      );
}
