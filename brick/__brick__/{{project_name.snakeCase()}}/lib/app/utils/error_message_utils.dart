import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/extensions.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';

class ErrorMessageUtils {
  ErrorMessageUtils._();

  static String generate(BuildContext context, dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Failure) {
      if (error is ServerError) {
        return _parseMessage(context, error);
      } else if (error is UnexpectedError) {
        return error.error ?? context.l10n.common_error_unexpected_error;
      } else if (error is EmptyString) {
        return context.l10n
            .common_error_empty_string(error.property.toString());
      } else if (error is InvalidEmailFormat) {
        return context.l10n.common_error_email_format;
      } else if (error is ExceedingCharacterLength) {
        return error.max != null
            ? context.l10n.common_error_max_characters
            : context.l10n.common_error_min_characters;
      } else {
        return error.toString();
      }
    } else {
      return error.toString();
    }
  }

  static String _parseMessage(BuildContext context, dynamic error) {
    try {
      final Map<String, dynamic> object =
          jsonDecode(error.error?.toString() ?? '{}') as Map<String, dynamic>;
      if (object['message'] != null) {
        return context.l10n.common_error_server_error(
          error.code.value.toString(),
          object['message'].toString(),
        );
      } else if (object['error'] != null) {
        return context.l10n.common_error_server_error(
          error.code.value.toString(),
          object['error'].toString(),
        );
      } else {
        return context.l10n.common_error_server_error(
          error.code.value.toString(),
          error.error.toString(),
        );
      }
    } catch (e) {
      return e.toString();
    }
  }
}
