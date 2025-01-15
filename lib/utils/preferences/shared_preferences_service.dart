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
