import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:very_good_core/app/themes/text_styles.dart';
import 'package:very_good_core/app/utils/extensions.dart';
import 'package:very_good_core/app/utils/hooks.dart';

class ErrorScreen extends HookWidget {
  const ErrorScreen({
    super.key,
    required this.onRefresh,
    required this.errorMessage,
    this.enablePullDown = true,
  });

  final VoidCallback? onRefresh;
  final String? errorMessage;
  final bool enablePullDown;

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = useRefreshController();

    return SmartRefresher(
      controller: refreshController,
      header: const ClassicHeader(),
      onRefresh: onRefresh,
      enablePullDown: enablePullDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.error, size: 50),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 12),
            child: Text(
              context.l10n.common_generic_error,
              style: AppTextStyle.subtitle1,
            ),
          ),
          if (kDebugMode && (errorMessage?.isNotNullOrBlank ?? false))
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: AppTextStyle.subtitle2,
              ),
            ),
        ],
      ),
    );
  }
}
