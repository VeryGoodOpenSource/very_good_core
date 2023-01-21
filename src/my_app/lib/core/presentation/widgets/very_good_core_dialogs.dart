import 'package:flutter/material.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';
import 'package:very_good_core/app/utils/extensions.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.message,
    this.title,
    this.negativeButtonText,
    this.positiveButtonText,
    this.onNegativePressed,
    this.onPositivePressed,
    this.negativeButtonColor,
    this.positiveButtonColor,
  });
  final String message;
  final String? title;
  final String? negativeButtonText;
  final String? positiveButtonText;
  final VoidCallback? onNegativePressed;
  final VoidCallback? onPositivePressed;
  final Color? negativeButtonColor;
  final Color? positiveButtonColor;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title:
            title != null ? Text(title!, style: AppTextStyle.subtitle1) : null,
        content: Padding(
          padding: title != null
              ? EdgeInsets.zero
              : EdgeInsets.only(top: Insets.xxs),
          child: Text(
            message,
            style: AppTextStyle.bodyText2,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onNegativePressed ?? () => Navigator.of(context).pop(),
            child: Text(
              negativeButtonText ?? context.l10n.common_no.toUpperCase(),
              style: AppTextStyle.button.copyWith(color: negativeButtonColor),
            ),
          ),
          TextButton(
            onPressed: onPositivePressed ?? () => Navigator.of(context).pop(),
            child: Text(
              positiveButtonText ?? context.l10n.common_yes.toUpperCase(),
              style: AppTextStyle.button.copyWith(color: positiveButtonColor),
            ),
          ),
        ],
      );
}
