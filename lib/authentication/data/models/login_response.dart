class LoginResponse {
  final dynamic message;
  final String? token;
  final int? statusCode;

  LoginResponse({
    required this.message,
    this.token,
    this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final dynamic msg = json['message'];
    String finalMessage;

    if (msg is List) {
      finalMessage = msg.join('\n');
    } else if (msg is String) {
      finalMessage = msg;
    } else {
      finalMessage = 'Unknown response format';
    }

    return LoginResponse(
      message: finalMessage,
      token: json['data'],
      statusCode: json['statusCode'],
    );
  }
}
