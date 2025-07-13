class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });
}
