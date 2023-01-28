import 'package:flutter/material.dart';
import 'package:very_good_core/app/themes/app_theme.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';

class VeryGoodCoreButton extends StatelessWidget {
  const VeryGoodCoreButton({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.isExpanded = false,
    required this.onPressed,
    this.buttonStyle,
    this.textStyle,
    this.padding,
    this.contentPadding,
  });

  final String text;
  final bool isEnabled;
  final bool isExpanded;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) => Semantics(
        key: Key(text),
        enabled: isEnabled,
        button: true,
        label: text,
        child: SizedBox(
          width: isExpanded ? double.infinity : null,
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.med),
            child: ElevatedButton(
              onPressed: isEnabled ? onPressed : null,
              style: buttonStyle ??
                  ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.defaultBoardRadius,
                    ),
                  ),
              child: Padding(
                padding: contentPadding ?? EdgeInsets.all(Insets.sm),
                child: isEnabled
                    ? Text(
                        text,
                        style: textStyle ??
                            AppTextStyle.labelLarge.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      )
                    : Center(
                        child: SizedBox.square(
                          dimension: textStyle?.fontSize ??
                              AppTextStyle.labelLarge.fontSize,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
}
