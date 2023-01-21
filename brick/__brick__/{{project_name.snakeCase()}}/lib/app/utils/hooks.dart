import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

RefreshController useRefreshController() => use(_RefreshControllerHook());

class _RefreshControllerHook extends Hook<RefreshController> {
  @override
  HookState<RefreshController, Hook<RefreshController>> createState() =>
      _RefreshControllerHookState();
}

class _RefreshControllerHookState
    extends HookState<RefreshController, _RefreshControllerHook> {
  late final RefreshController controller = RefreshController();

  @override
  RefreshController build(BuildContext context) => controller;
}
