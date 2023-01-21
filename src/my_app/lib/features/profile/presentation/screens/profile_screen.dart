import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';
import 'package:very_good_core/app/utils/error_message_utils.dart';
import 'package:very_good_core/app/utils/extensions.dart';
import 'package:very_good_core/app/utils/hooks.dart';
import 'package:very_good_core/core/domain/bloc/very_good_core/very_good_core_bloc.dart';
import 'package:very_good_core/core/domain/model/user.dart';
import 'package:very_good_core/core/presentation/screens/error_screen.dart';
import 'package:very_good_core/core/presentation/screens/loading_screen.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_avatar.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_button.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_info_text_field.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = useRefreshController();

    return BlocBuilder<VeryGoodCoreBloc, VeryGoodCoreState>(
      builder: (BuildContext context, VeryGoodCoreState state) {
        final User user = state.user!;
        final bool hasContactNumber =
            user.contactNumber?.getOrCrash().isNotNullOrBlank ?? false;
        if (state.isLoading) {
          return const LoadingScreen();
        } else if (state.failure != null) {
          return ErrorScreen(
            onRefresh: () async => context.read<VeryGoodCoreBloc>().getUser(),
            errorMessage: ErrorMessageUtils.generate(context, state.failure),
          );
        }

        return SmartRefresher(
          controller: refreshController,
          header: const ClassicHeader(),
          onRefresh: () async => context.read<VeryGoodCoreBloc>().getUser(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                VSpace(Insets.lg),
                Text(
                  context.l10n.profile__header_text__basic_information,
                  style: AppTextStyle.headline4,
                ),
                VSpace(Insets.med),
                Row(
                  children: <Widget>[
                    VeryGoodCoreAvatar(
                      size: 100,
                      imageUrl: user.avatar?.getOrCrash(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Insets.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              user.firstName.getOrCrash(),
                              style: AppTextStyle.headline2,
                            ),
                            Text(
                              user.lastName.getOrCrash(),
                              style: AppTextStyle.headline2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                VSpace(Insets.xl),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      VSpace.sm,
                      VeryGoodCoreInfoTextField(
                        title: context.l10n.profile__label_text__email,
                        description: user.email.getOrCrash(),
                      ),
                      if (hasContactNumber) VSpace.sm,
                      if (hasContactNumber)
                        VeryGoodCoreInfoTextField(
                          title: context.l10n.profile__label_text__phone_number,
                          description: user.contactNumber!.getOrCrash(),
                        ),
                      VSpace.sm,
                      VeryGoodCoreInfoTextField(
                        title: context.l10n.profile__label_text__gender,
                        description: user.gender.name.capitalize(),
                      ),
                      VSpace.sm,
                      VeryGoodCoreInfoTextField(
                        title: context.l10n.profile__label_text__birthday,
                        description: user.birthday.defaultFormat(),
                      ),
                      VSpace.sm,
                      VeryGoodCoreInfoTextField(
                        title: context.l10n.profile__label_text__age,
                        description: user.age,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: VeryGoodCoreButton(
                    isExpanded: true,
                    padding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.symmetric(vertical: Insets.med),
                    text: context.l10n.profile__button_text__logout,
                    onPressed: () => context.read<VeryGoodCoreBloc>().logout(),
                  ),
                ),
                VSpace(Insets.lg),
              ],
            ),
          ),
        );
      },
    );
  }
}
