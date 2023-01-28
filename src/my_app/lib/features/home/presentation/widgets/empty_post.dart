import 'package:flutter/material.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';
import 'package:very_good_core/app/utils/extensions.dart';

class EmptyPost extends StatelessWidget {
  const EmptyPost({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: Insets.lg),
        color: Theme.of(context).colorScheme.background,
        width: double.infinity,
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
              padding: EdgeInsets.only(top: Insets.sm, bottom: Insets.xs),
              child: Text(
                context.l10n.post__empty_post__empty_post_message,
                style: AppTextStyle.titleLarge.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.25),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
