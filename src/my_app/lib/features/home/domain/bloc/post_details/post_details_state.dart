part of 'post_details_bloc.dart';

@freezed
class PostDetailsState with _$PostDetailsState {
  factory PostDetailsState({
    required Url webviewUrl,
    required WebViewController controller,
  }) = _PostDetailsState;

  factory PostDetailsState.initial(
    Url webviewUrl,
    WebViewController controller,
  ) =>
      _PostDetailsState(
        webviewUrl: webviewUrl,
        controller: controller,
      );
}
