import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/features/home/domain/bloc/post_details/post_details_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'post_details_bloc_test.mocks.dart';

@GenerateMocks(<Type>[WebViewController])
void main() {
  late Url loadUrl;
  late PostDetailsBloc postDetailsBloc;
  late WebViewController webViewController;
  setUp(() {
    loadUrl = Url('http://www.example.com');

    webViewController = MockWebViewController();

    postDetailsBloc = PostDetailsBloc(loadUrl, webViewController);
  });

  group('PostDetails loadView', () {
    blocTest<PostDetailsBloc, PostDetailsState>(
      'should emit the new url',
      build: () => postDetailsBloc,
      act: (PostDetailsBloc bloc) async =>
          bloc.loadView(Url('http://www.example123.com')),
      expect: () => <dynamic>[
        postDetailsBloc.state
            .copyWith(webviewUrl: Url('http://www.example123.com')),
      ],
    );
  });
  group('PostDetails webViewBack', () {
    test(
      'should return false',
      () async {
        // arrange
        when(postDetailsBloc.state.controller.canGoBack())
            .thenAnswer((_) async => true);
        // act
        final bool canGoBack = await postDetailsBloc.webViewBack();
        // assert
        expect(canGoBack, false);
      },
    );
    test(
      'should return true',
      () async {
        // arrange
        when(postDetailsBloc.state.controller.canGoBack())
            .thenAnswer((_) async => false);
        // act
        final bool canGoBack = await postDetailsBloc.webViewBack();
        // assert
        expect(canGoBack, true);
      },
    );
  });
}
