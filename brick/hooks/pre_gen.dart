import 'package:mason/mason.dart';
import 'package:recase/recase.dart';

void run(HookContext context) {
  context.vars['current_year'] = DateTime.now().year;

  context.vars['application_id_android'] = _appId(true, context);
  context.vars['application_id_ios'] = _appId(false, context);
}

String _appId(bool android, HookContext context) {
  final orgName = context.vars['org_name'];
  final projectName = context.vars['project_name'];

  String? applicationId = context.vars['application_id'];
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '${orgName}.${android ? ReCase(projectName).snakeCase : ReCase(projectName).paramCase}';

  return applicationId!;
}
