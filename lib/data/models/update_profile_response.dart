class UpdateProfileResponse {
  final bool status;
  final String message;
  final ProfileData data;

  UpdateProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}

class ProfileData {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String avatar;

  ProfileData({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.avatar,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }
}
