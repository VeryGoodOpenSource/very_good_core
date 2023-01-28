import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/utils/dialog_utils.dart';
import 'package:very_good_core/app/utils/error_message_utils.dart';
import 'package:very_good_core/app/utils/hooks.dart';
import 'package:very_good_core/core/presentation/screens/loading_screen.dart';
import 'package:very_good_core/features/home/domain/bloc/post/post_bloc.dart';
import 'package:very_good_core/features/home/presentation/widgets/empty_post.dart';
import 'package:very_good_core/features/home/presentation/widgets/post_container.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = useRefreshController();
    final ValueNotifier<bool> isDialogShowing = useState(false);

    return BlocConsumer<PostBloc, PostState>(
      builder: (BuildContext context, PostState state) {
        if (state.isLoading) {
          return const LoadingScreen();
        }

        return SmartRefresher(
          controller: refreshController,
          header: const ClassicHeader(),
          onRefresh: () => context.read<PostBloc>().getPosts(),
          child: state.posts.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      PostContainer(post: state.posts[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      VSpace(Insets.sm),
                  itemCount: state.posts.length,
                )
              : const EmptyPost(),
        );
      },
      listener: (BuildContext context, PostState state) =>
          _homeScreenListener(context, state, isDialogShowing),
    );
  }

  Future<void> _homeScreenListener(
    BuildContext context,
    PostState state,
    ValueNotifier<bool> isDialogShowing,
  ) async {
    if (state.failure != null && !isDialogShowing.value) {
      isDialogShowing.value = true;
      await DialogUtils.showToast(
        context,
        ErrorMessageUtils.generate(context, state.failure),
      );
      isDialogShowing.value = false;
    }
  }
}
