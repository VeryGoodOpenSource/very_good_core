import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/app/generated/l10n.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_colors.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_theme.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/spacing.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/text_styles.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_dialogs.dart';

class DialogUtils {
  DialogUtils._();

  static Future<bool> showExitDialog(BuildContext context) async =>
      await DialogUtils.showConfirmationDialog(
        context,
        message: AppLocalizations.of(context).dialog__message__exit_message,
        onPositivePressed: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
      ) ??
      false;

  static Future<void>? showOfflineDialog<T>(
    BuildContext context, {
    Duration? duration,
  }) =>
      showFlash(
        context: context,
        duration: duration,
        builder: (BuildContext context, FlashController<void> controller) =>
            Flash<void>(
          controller: controller,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: AppColors.charcoal,
          barrierDismissible: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Insets.med,
            ),
            child: FlashBar(
              content: Text(
                ConnectionStatus.offline.name.capitalize(),
                style: AppTextStyle.bodyText2.copyWith(color: AppColors.white),
              ),
              icon: const Icon(Icons.wifi_off, color: AppColors.white),
            ),
          ),
        ),
      );

  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String message,
    String? title,
    String? negativeButtonText,
    String? positiveButtonText,
    VoidCallback? onNegativePressed,
    VoidCallback? onPositivePressed,
    Color? negativeButtonColor,
    Color? positiveButtonColor,
  }) =>
      showDialog<bool?>(
        context: context,
        builder: (BuildContext context) => ConfirmationDialog(
          message: message,
          title: title,
          negativeButtonText: negativeButtonText,
          positiveButtonText: positiveButtonText,
          onNegativePressed: onNegativePressed,
          onPositivePressed: onPositivePressed,
          negativeButtonColor: negativeButtonColor,
          positiveButtonColor: positiveButtonColor,
        ),
      );

  static Future<void> showToast(
    BuildContext context,
    String message, {
    Icon? icon,
    Duration? duration,
    FlashPosition? position,
  }) =>
      showFlash(
        context: context,
        duration: duration ?? const Duration(seconds: 2),
        builder: (BuildContext context, FlashController<Object?> controller) =>
            Flash<dynamic>.bar(
          controller: controller,
          position: position ?? FlashPosition.top,
          backgroundColor: Theme.of(context).colorScheme.background,
          margin: EdgeInsets.all(Insets.med),
          borderRadius: AppTheme.defaultBoardRadius,
          boxShadows: const <BoxShadow>[
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.med,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(right: Insets.sm),
                    child: icon,
                  ),
                Flexible(
                  child: Text(
                    message,
                    style: AppTextStyle.caption,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
