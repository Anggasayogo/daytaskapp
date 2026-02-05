import 'package:shared_preferences/shared_preferences.dart';

// Simpan token
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

// Ambil token yang disimpan
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

// Hapus token
Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}

// =========== saving users id ==============

// Simpan userId sebagai String
Future<void> saveUserId(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId.toString());
}

// Ambil userId yang disimpan
Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId'); // Konsisten mengambil sebagai String
}

// Hapus userId
Future<void> clearUserId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
}

//  ============== Saving roleId ====================


// Simpan roleId sebagai String
Future<void> saveRoleId(int roleId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('roleId', roleId.toString());
}

// Ambil roleId yang disimpan
Future<String?> getRoleId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('roleId'); // Konsisten mengambil sebagai String
}

// Hapus roleId
Future<void> clearRoleId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('roleId');
}

//  ============== Saving Avatar ====================

// Simpan roleId sebagai String
Future<void> saveAvatar(String avatar) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('avatar', avatar);
}

// Ambil Avatar yang disimpan
Future<String?> getAvatar() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('avatar'); // Konsisten mengambil sebagai String
}

// Hapus Avatar
Future<void> clearAvatar() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('avatar');
}


//  ============== Saving username ====================

// Simpan Username sebagai String
Future<void> saveUsername(String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}

// Ambil Username yang disimpan
Future<String?> getUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('username'); // Konsisten mengambil sebagai String
}

// Hapus Username
Future<void> clearUsername() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
}


//  ============== Saving email ====================

// Simpan email sebagai String
Future<void> saveEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

// Ambil email yang disimpan
Future<String?> getEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email'); // Konsisten mengambil sebagai String
}

// Hapus email
Future<void> clearEmail() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('email');
}
