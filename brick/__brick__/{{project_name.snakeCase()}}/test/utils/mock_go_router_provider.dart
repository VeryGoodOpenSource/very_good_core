import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.router,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final GoRouter router;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: router,
        child: child,
      );
}
