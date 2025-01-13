class LoginModel {
  final bool status;
  final String message;
  final UserModel user;
  final String token;

  LoginModel({
    required this.status,
    required this.message,
    required this.user,
    required this.token
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? false, 
      message: json['message'] ?? '', 
      user: UserModel.fromJson(json['user'] ?? {}), 
      token: json['token'] ?? '', 
    );
  }
}

class UserModel {
  final int user_id;
  final String username;
  final String email;
  final String phone;
  final String? avatar;

   UserModel({
    required this.user_id,
    required this.username,
    required this.email,
    required this.phone,
    this.avatar
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}