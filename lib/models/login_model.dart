class LoginModel {
  String email;
  String password;

  LoginModel({required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
