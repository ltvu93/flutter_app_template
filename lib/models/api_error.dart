abstract class ApiError implements Exception {}

class UnknownError extends ApiError {}

class NetworkTimeoutError extends ApiError {}

class UnAuthenticateError extends ApiError {}

class ServerError extends ApiError {
  final List<ServerErrorContent> errors;

  ServerError({required this.errors});

  ServerErrorContent? get firstError => errors.isNotEmpty ? errors[0] : null;

  factory ServerError.fromJson(Map<String, dynamic>? json) {
    return ServerError(
      errors: json != null
          ? List<ServerErrorContent>.from(
              json['errors'].map(
                (x) => ServerErrorContent.fromJson(x),
              ),
            )
          : <ServerErrorContent>[],
    );
  }
}

class ServerErrorContent {
  final int code;
  final String message;

  ServerErrorContent({
    required this.code,
    required this.message,
  });

  factory ServerErrorContent.fromJson(Map<String, dynamic> json) {
    return ServerErrorContent(
      code: json['code'],
      message: json['message'],
    );
  }
}
