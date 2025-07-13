class ApiError {
  final int statusCode;
  final String message;

  ApiError({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => 'ApiError($statusCode): $message';
}
