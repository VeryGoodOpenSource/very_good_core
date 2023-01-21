import 'package:chopper/chopper.dart';

part 'post_service.chopper.dart';

@ChopperApi(baseUrl: 'https://www.reddit.com')
abstract class PostService extends ChopperService {
  @Get(path: '/r/FlutterDev.json')
  Future<Response<dynamic>> getPosts();

  static PostService create() => _$PostService();
}
