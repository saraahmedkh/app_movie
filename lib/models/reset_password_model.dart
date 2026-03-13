// reset password request model
class ResetPasswordRequest {
  final String oldPassword;
  final String newPassword;

  ResetPasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}

// Reset Password Response Model
class ResetPasswordResponse {
  final String message;

  ResetPasswordResponse({required this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      message: json['message'] ?? '',
    );
  }
}