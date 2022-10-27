import 'package:mason/mason.dart';
import 'package:recase/recase.dart';

void run(HookContext context) {
  context.vars['current_year'] = DateTime.now().year;

  context.vars['application_id_android'] = _appId(context, isAndroid: true);
  context.vars['application_id_ios'] = _appId(context, isAndroid: false);
}

String _appId(HookContext context, { required bool isAndroid }) {
  final orgName = context.vars['org_name'];
  final projectName = context.vars['project_name'];

  String? applicationId = context.vars['application_id'];
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '${orgName}.${isAndroid ? ReCase(projectName).snakeCase : ReCase(projectName).paramCase}';

  return applicationId!;
}
