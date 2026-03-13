class LoginResponse {
  final String message;
  final LoginData data;

  LoginResponse({
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  final String token;
  final UserData user;

  LoginData({
    required this.token,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] ?? '',
      user: UserData.fromJson(json['user']),
    );
  }
}

class UserData {
  final String id;
  final String email;
  final String name;
  final String phone;
  final int avaterId;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avaterId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avaterId: json['avaterId'] ?? 0,
    );
  }
}