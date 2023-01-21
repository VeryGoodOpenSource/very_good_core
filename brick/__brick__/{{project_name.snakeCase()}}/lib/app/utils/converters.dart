import 'package:freezed_annotation/freezed_annotation.dart';

class StringToDateTime implements JsonConverter<DateTime, String> {
  const StringToDateTime();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime json) => json.toIso8601String();
}

class TimestampToDateTime implements JsonConverter<DateTime, double> {
  const TimestampToDateTime();

  @override
  DateTime fromJson(double json) {
    final int value = json.toInt();
    final int length = value.toString().length;
    // Check if timestamp is in seconds
    if (length == 10) {
      return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      // Check if timestamp is in milliseconds
    } else if (length == 13) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else {
      // timestamp is in microseconds
      return DateTime.fromMicrosecondsSinceEpoch(value);
    }
  }

  @override
  double toJson(DateTime json) =>
      json.millisecondsSinceEpoch / 1000; // timestamp in seconds
}
