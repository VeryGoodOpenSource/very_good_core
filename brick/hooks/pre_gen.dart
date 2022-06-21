import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars['current_year'] = DateTime.now().year;
}
