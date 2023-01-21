import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'post_details_bloc.freezed.dart';
part 'post_details_state.dart';

@injectable
class PostDetailsBloc extends Cubit<PostDetailsState> {
  PostDetailsBloc(
    @factoryParam this.loadUrl,
    @factoryParam this.controller,
  ) : super(PostDetailsState.initial(loadUrl, controller));

  final Url loadUrl;
  final WebViewController controller;

  Future<void> loadView(Url webviewUrl) async {
    await state.controller.loadRequest(Uri.parse(webviewUrl.getOrCrash()));
    emit(state.copyWith(webviewUrl: webviewUrl));
  }

  Future<bool> webViewBack() async {
    final bool canGoBack = await state.controller.canGoBack();

    if (canGoBack) {
      await state.controller.goBack();

      return Future<bool>.value(false);
    } else {
      return Future<bool>.value(true);
    }
  }
}
