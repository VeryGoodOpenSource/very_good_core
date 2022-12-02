import 'package:mason/mason.dart';
import 'package:recase/recase.dart';

enum Platform {
  android,
  ios,
}

void run(HookContext context) {
  context.vars['application_id_android'] =
      _appId(context, platform: Platform.android);
  context.vars['application_id'] = _appId(context);
}

String _appId(HookContext context, {Platform? platform}) {
  final orgName = context.vars['org_name'];
  final projectName = context.vars['project_name'];

  String? applicationId = context.vars['application_id'];
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '${orgName}.${platform == Platform.android ? ReCase(projectName).snakeCase : ReCase(projectName).paramCase}';

  return applicationId!;
}
