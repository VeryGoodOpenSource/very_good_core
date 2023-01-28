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
      enablePullDown: enablePullDown,
      onRefresh: onRefresh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.error, size: 50),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Text(
              context.l10n.common_generic_error,
              style: AppTextStyle.titleMedium,
            ),
          ),
          if (kDebugMode && (errorMessage?.isNotNullOrBlank ?? false))
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Text(
                errorMessage!,
                style: AppTextStyle.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
