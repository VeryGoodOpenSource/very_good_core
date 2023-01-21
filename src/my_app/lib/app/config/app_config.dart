import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get environment => dotenv.env['ENV'] ?? 'Development';
  static String get baseApiUrl => dotenv.env['BASE_API_URL'] ?? '';
}
