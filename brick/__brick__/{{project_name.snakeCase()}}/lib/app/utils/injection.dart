import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies(Env env) =>
    getIt.init(environment: env.value);
