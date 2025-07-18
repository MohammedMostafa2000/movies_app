class RegisterResponse {
  final String message;
  final String? error;
  final int? statusCode;

  RegisterResponse({
    required this.message,
    this.error,
    this.statusCode,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final dynamic msg = json['message'];
    String finalMessage;

    if (msg is List) {
      finalMessage = msg.join('\n');
    } else if (msg is String) {
      finalMessage = msg;
    } else {
      finalMessage = 'Unknown response format';
    }

    return RegisterResponse(
      message: finalMessage,
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }
}
