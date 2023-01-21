import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/app/generated/l10n.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right<L, R>).value;
  L asLeft() => (this as Left<L, R>).value;
}

extension StatusCodeX on StatusCode {
  bool get isSuccess => value == 200 || value == 201 || value == 204;
}

extension IntX on int {
  StatusCode get statusCode => StatusCode.values.firstWhere(
        (StatusCode element) => element.value == this,
        orElse: () => StatusCode.api000,
      );
}

extension DateTimeX on DateTime {
  String defaultFormat() => DateFormat('MMM dd, yyyy').format(this);

  String get ago => timeago.format(
        DateTime.now()
            .toUtc()
            .subtract(DateTime.now().toUtc().difference(this)),
      );
}

extension ColorX on Color {
  String _generateAlpha({required int alpha, required bool withAlpha}) =>
      withAlpha ? alpha.toRadixString(16).padLeft(2, '0') : '';

  String toHex({bool hashSign = false, bool withAlpha = false}) =>
      '${hashSign ? '#' : ''}'
              '${_generateAlpha(alpha: alpha, withAlpha: withAlpha)}'
              '${red.toRadixString(16).padLeft(2, '0')}'
              '${green.toRadixString(16).padLeft(2, '0')}'
              '${blue.toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();

  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
