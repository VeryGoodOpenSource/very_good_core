import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/route.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/transition_page_utils.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/screens/splash_screen.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/screens/{{project_name.snakeCase()}}_screen.dart';
import 'package:{{project_name.snakeCase()}}/features/auth/presentation/screen/login_screen.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/model/post.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/screens/home_screen.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/screens/post_details_webview.dart';
import 'package:{{project_name.snakeCase()}}/features/profile/presentation/screens/profile_screen.dart';

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
          navigatorKey: shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) =>
              {{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(child: child),
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
        ),
      ];
}
