// Register Request Model
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avaterId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avaterId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'avaterId': avaterId,
    };
  }
}

// Register Response Model
class RegisterResponse {
  final String message;
  final RegisterData data;

  RegisterResponse({
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] ?? '',
      data: RegisterData.fromJson(json['data']),
    );
  }
}

class RegisterData {
  final String id;
  final String email;
  final String name;
  final String phone;
  final int avaterId;
  final String createdAt;
  final String updatedAt;

  RegisterData({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avaterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avaterId: json['avaterId'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}