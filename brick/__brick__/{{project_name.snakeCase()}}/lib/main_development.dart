import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';

void main() {
  bootstrap(App.new, Env.development);
}
