import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:very_good_core/app/constants/constant.dart';
import 'package:very_good_core/app/themes/app_colors.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';
import 'package:very_good_core/core/domain/bloc/very_good_core/very_good_core_bloc.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_avatar.dart';

class VeryGoodCoreAppBar extends HookWidget {
  const VeryGoodCoreAppBar({
    super.key,
    this.avatar,
  });

  final Url? avatar;

  @override
  Widget build(BuildContext context) => AppBar(
        leading: GoRouter.of(context).canPop()
            ? BackButton(
                onPressed: () => GoRouter.of(context).canPop()
                    ? GoRouter.of(context).pop()
                    : null,
              )
            : null,
        title: Text(
          Constant.appName,
          style: AppTextStyle.headlineSmall.copyWith(color: AppColors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => context
                .read<VeryGoodCoreBloc>()
                .switchTheme(Theme.of(context).brightness),
            icon: Theme.of(context).brightness == Brightness.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
          VeryGoodCoreAvatar(
            size: 32,
            imageUrl: avatar?.getOrCrash(),
            padding: EdgeInsets.all(Insets.sm),
          ),
        ],
      );
}
