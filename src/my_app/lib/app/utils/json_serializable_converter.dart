import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:very_good_core/core/data/model/resource_error.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  const JsonSerializableConverter(this.factories);
  final Map<Type, JsonFactory> factories;

  T? _decodeMap<T>(Map<String, dynamic> values) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null
    final JsonFactory? jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable<dynamic> values) => values
      .where((dynamic v) => v != null)
      .map<T>((dynamic v) => _decode<T>(v))
      .toList();

  dynamic _decode<T>(dynamic entity) {
    if (entity is Iterable) return _decodeList<T>(entity as List<dynamic>);

    if (entity is Map) return _decodeMap<T>(entity as Map<String, dynamic>);

    return entity;
  }

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
    Response<dynamic> response,
  ) async {
    // use [JsonConverter] to decode json
    final Response<dynamic> jsonRes = await super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(body: _decode<Item>(jsonRes.body));
  }

  @override
  // all objects should implements toJson method
  // ignore: unnecessary_overrides
  Request convertRequest(Request request) => super.convertRequest(request);

  @override
  FutureOr<Response<dynamic>> convertError<ResultType, Item>(
    Response<dynamic> response,
  ) async {
    // use [JsonConverter] to decode json
    final Response<dynamic> jsonRes = await super.convertError(response);

    return jsonRes.copyWith<ResourceError>(
      body: ResourceError.fromJsonFactory(jsonRes.body),
    );
  }
}
