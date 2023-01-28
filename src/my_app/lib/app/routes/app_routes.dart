import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:very_good_core/app/constants/route.dart';
import 'package:very_good_core/app/utils/transition_page_utils.dart';
import 'package:very_good_core/core/presentation/screens/splash_screen.dart';
import 'package:very_good_core/core/presentation/screens/very_good_core_screen.dart';
import 'package:very_good_core/features/auth/presentation/screen/login_screen.dart';
import 'package:very_good_core/features/home/domain/model/post.dart';
import 'package:very_good_core/features/home/presentation/screens/home_screen.dart';
import 'package:very_good_core/features/home/presentation/screens/post_details_webview.dart';
import 'package:very_good_core/features/profile/presentation/screens/profile_screen.dart';

@injectable
class AppRoutes {
  AppRoutes(
    @factoryParam this.shellNavigatorKey,
    @factoryParam this.scaffoldKey,
  );

  final GlobalKey<NavigatorState> shellNavigatorKey;
  final ValueKey<String> scaffoldKey;

  List<RouteBase> get routes => <RouteBase>[
        GoRoute(
          path: RouteName.initial.path,
          name: RouteName.initial.name,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        ),
        GoRoute(
          path: RouteName.login.path,
          name: RouteName.login.name,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) =>
              VeryGoodCoreScreen(child: child),
          routes: <RouteBase>[
            GoRoute(
              path: RouteName.home.path,
              name: RouteName.home.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  FadeTransitionPage(
                key: scaffoldKey,
                child: const HomeScreen(),
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: RouteName.postDetails.path,
                  name: RouteName.postDetails.name,
                  builder: (BuildContext context, GoRouterState state) {
                    if (state.extra is Post) {
                      final Post post = state.extra! as Post;

                      return PostDetailsWebview(post: post);
                    }

                    return const HomeScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              path: RouteName.profile.path,
              name: RouteName.profile.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  FadeTransitionPage(
                key: scaffoldKey,
                child: const ProfileScreen(),
              ),
            ),
          ],
          navigatorKey: shellNavigatorKey,
        ),
      ];
}
