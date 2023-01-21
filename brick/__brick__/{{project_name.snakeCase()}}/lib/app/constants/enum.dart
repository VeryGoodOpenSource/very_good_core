enum Env {
  development('dev'),
  staging('stg'),
  production('prod'),
  test('test');

  const Env(this.value);
  final String value;
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  unknown,
}

enum StatusCode {
  /// OK. Everything worked as expected.
  api200(200),

  /// A resource was successfully created in response to a POST request. The Location header contains the URL pointing to the newly created resource.
  api201(201),

  /// The request was handled successfully and the response contains no body content (like a DELETE request).
  api204(204),

  /// The resource was not modified. You can use the cached version.
  api304(304),

  /// Bad request. This could be caused by various actions by the user, such as providing invalid JSON data in the request body etc.
  api400(400),

  /// Authentication failed.
  api401(401),

  /// The authenticated user is not allowed to access the specified API endpoint.
  api403(403),

  /// The requested resource does not exist.
  api404(404),

  /// Method not allowed. Please check the Allow header for the allowed HTTP methods.
  api405(405),

  /// Unsupported media type. The requested content type or version number is invalid.
  api415(415),

  /// Data validation failed (in response to a POST request, for example). Please check the response body for detailed error messages.
  api422(422),

  /// Too many requests. The request was rejected due to rate limiting.
  api429(429),

  /// Internal server error. This could be caused by internal program errors.
  api500(500),

  /// Unknown status code or error
  api000(000);

  const StatusCode(this.value);
  final int value;
}

enum ConnectionStatus {
  online,
  offline,
}

enum Gender {
  male,
  female,
  unknown,
}
