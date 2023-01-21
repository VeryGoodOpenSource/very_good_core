import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:{{project_name.snakeCase()}}/app/constants/constant.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_colors.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/spacing.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/text_styles.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/bloc/{{project_name.snakeCase()}}/{{project_name.snakeCase()}}_bloc.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/value_objects.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_avatar.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar extends HookWidget {
  const {{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar({
    super.key,
    this.avatar,
  });

  final Url? avatar;

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          Constant.appName,
          style: AppTextStyle.headline5.copyWith(color: AppColors.white),
        ),
        leading: GoRouter.of(context).canPop()
            ? BackButton(
                onPressed: () => GoRouter.of(context).canPop()
                    ? GoRouter.of(context).pop()
                    : null,
              )
            : null,
        actions: <Widget>[
          IconButton(
            onPressed: () => context
                .read<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc>()
                .switchTheme(Theme.of(context).brightness),
            icon: Theme.of(context).brightness == Brightness.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
          {{#pascalCase}}{{project_name}}{{/pascalCase}}Avatar(
            size: 32,
            imageUrl: avatar?.getOrCrash(),
            padding: EdgeInsets.all(Insets.sm),
          ),
        ],
      );
}
