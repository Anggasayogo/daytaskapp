class UserListResponse {
  final List<User> users;

  UserListResponse({required this.users});

  factory UserListResponse.fromJson(List<dynamic> json) {
    // Pastikan json adalah List<dynamic> dari respons API
    List<User> usersList = json.map((i) => User.fromJson(i)).toList();
    return UserListResponse(users: usersList);
  }
}

class User {
  final int userId;
  final String username;
  final String email;
  final String phone;
  final String avatar;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'] ?? "-", // Defaultkan avatar jika null
    );
  }
}
