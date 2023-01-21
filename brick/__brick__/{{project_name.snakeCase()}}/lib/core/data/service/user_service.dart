import 'package:chopper/chopper.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: 'https://reqres.in/api')
abstract class UserService extends ChopperService {
  @Get(path: '/users/2')
  Future<Response<dynamic>> getCurrentUser();

  static UserService create() => _$UserService();
}
