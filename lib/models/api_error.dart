abstract class ApiError implements Exception {}

class UnknownError extends ApiError {}

class NetworkTimeoutError extends ApiError {}

class ServerError extends ApiError {
  final List<ServerErrorContent> errors;

  ServerError({this.errors});

  ServerErrorContent get firstError => errors.isNotEmpty ? errors[0] : null;

  factory ServerError.fromJson(Map<String, dynamic> json) {
    final errorsJson = json['errors'];

    return ServerError(
      errors: json != null
          ? List<ServerErrorContent>.from(
              errorsJson.map(
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

  ServerErrorContent({this.code, this.message});

  factory ServerErrorContent.fromJson(Map<String, dynamic> json) {
    return ServerErrorContent(
      code: json['code'],
      message: json['message'],
    );
  }
}
