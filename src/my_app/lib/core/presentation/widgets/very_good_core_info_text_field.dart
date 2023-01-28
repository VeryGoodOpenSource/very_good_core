import 'package:flutter/material.dart';
import 'package:very_good_core/app/themes/app_theme.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';

class VeryGoodCoreInfoTextField extends StatelessWidget {
  const VeryGoodCoreInfoTextField({
    super.key,
    required this.title,
    required this.description,
    this.isExpanded = true,
  });

  final String title;
  final String description;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) => Semantics(
        textField: true,
        readOnly: true,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.med),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            borderRadius: AppTheme.defaultBoardRadius,
          ),
          width: isExpanded ? double.infinity : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: AppTextStyle.bodySmall),
              VSpace.xxs,
              Text(description, style: AppTextStyle.titleMedium),
            ],
          ),
        ),
      );
}
