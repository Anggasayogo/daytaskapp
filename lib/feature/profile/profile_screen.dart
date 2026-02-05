import 'package:daytaskapp/app/config/server_config.dart';
import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Ambil instance ApiService dari GetIt
  ApiService get _apiService => GetIt.I<ApiService>();

  Future<String?> _loadAvatar() async => await getAvatar();
  Future<String?> _loadUsername() async => await getUsername();
  Future<String?> _loadEmail() async => await getEmail();
  Future<String?> _loadRole() async => await getRoleId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Card(
                    color: Colors.white,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 15),
                      child: Row(
                        children: [
                          FutureBuilder<String?>(
                            future: _loadAvatar(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2));
                              }
                              final avatar = snapshot.data;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  avatar ??
                                      "${ServerConfig.mainBaseUrl}/assets/9815472.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.person,
                                        color: Colors.grey),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<String?>(
                                  future: _loadUsername(),
                                  builder: (context, snapshot) => Text(
                                      snapshot.data ?? "Username",
                                      style:
                                          semibold12_5.copyWith(fontSize: 16)),
                                ),
                                FutureBuilder<String?>(
                                  future: _loadEmail(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting)
                                      return const SizedBox.shrink();
                                    return Text(
                                        snapshot.data ?? "email@gmail.com",
                                        style: regular14.copyWith(
                                            fontSize: 13,
                                            color: Colors.grey.shade600));
                                  },
                                )
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.pushNamed(RoutePath.detail_profile),
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        children: [
                          _buildMenuRow(
                            icon: Icons.receipt_long_outlined,
                            text: 'Download Report',
                            onTap: () => context.push(RoutePath.report),
                          ),
                          _divider(),
                          FutureBuilder<String?>(
                            future: _loadRole(),
                            builder: (context, snapshot) {
                              final role = snapshot.data;
                              if (role == "2") {
                                return Column(children: [
                                  _buildMenuRow(
                                      icon: Icons.card_giftcard,
                                      text: 'Reward Saya',
                                      onTap: () =>
                                          context.push(RoutePath.reward_list)),
                                  _divider()
                                ]);
                              } else if (role == "1") {
                                return Column(children: [
                                  _buildMenuRow(
                                      icon: Icons.card_giftcard,
                                      text: 'Kelola Reward',
                                      onTap: () => context
                                          .push(RoutePath.kelola_reward_list)),
                                  _divider()
                                ]);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          _buildMenuRow(
                            icon: Icons.security_sharp,
                            text: 'Ubah Password',
                            onTap: () =>
                                _showChangePasswordBottomSheet(context),
                          ),
                          _divider(),
                          _buildMenuRow(
                              icon: Icons.privacy_tip_outlined,
                              text: 'Kebijakan Privasi',
                              onTap: () {}),
                          _divider(),
                          _buildMenuRow(
                            icon: Icons.logout_outlined,
                            text: 'Logout',
                            onTap: () async {
                              await clearRoleId();
                              await clearToken();
                              await clearUserId();
                              if (context.mounted) context.go(RoutePath.login);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text("V-1.0.0"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    final oldPassC = TextEditingController();
    final newPassC = TextEditingController();
    final confirmPassC = TextEditingController();

    bool obsOld = true;
    bool obsNew = true;
    bool obsConf = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 20),
              Text("Ubah Password", style: semibold14.copyWith(fontSize: 18)),
              const SizedBox(height: 25),
              _buildInputField("Password Lama", oldPassC,
                  isPassword: true,
                  obscureText: obsOld,
                  onToggle: () => setState(() => obsOld = !obsOld)),
              _buildInputField("Password Baru", newPassC,
                  isPassword: true,
                  obscureText: obsNew,
                  onToggle: () => setState(() => obsNew = !obsNew)),
              _buildInputField("Konfirmasi Password Baru", confirmPassC,
                  isPassword: true,
                  obscureText: obsConf,
                  onToggle: () => setState(() => obsConf = !obsConf)),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (oldPassC.text.isEmpty ||
                        newPassC.text.isEmpty ||
                        confirmPassC.text.isEmpty) {
                      _snack(context, "Semua field harus diisi");
                      return;
                    }
                    if (newPassC.text != confirmPassC.text) {
                      _snack(context, "Konfirmasi password tidak cocok");
                      return;
                    }

                    // Tampilkan loading
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      final userId = await getUserId();
                      final response = await _apiService.post(
                        path: '/api/v1/auth/user/changge-pwd/$userId',
                        data: {
                          "oldPassword": oldPassC.text,
                          "newPassword": newPassC.text,
                          "confirmPassword": confirmPassC.text,
                        },
                      );

                      // Tutup loading
                      if (context.mounted)
                        Navigator.of(context, rootNavigator: true).pop();

                      if (response.statusCode == 200 ||
                          response.statusCode == "200") {
                        if (context.mounted) Navigator.pop(context);
                        _snack(context, "Password berhasil diperbarui!");
                      } else {
                        if (context.mounted) _snack(context,"Gagal mengubah password");
                      }
                    } catch (e) {
                      if (context.mounted)
                        Navigator.of(context, rootNavigator: true).pop();

                      String errorMsg = "Terjadi kesalahan";

                      if (e.toString().contains("Password lama salah")) {
                        errorMsg = "Password lama salah";
                      } else if (e.toString().contains("400")) {
                        errorMsg = "Input tidak valid atau Password salah";
                      } else {
                        errorMsg = "Koneksi bermasalah, coba lagi";
                      }

                      _snack(context, errorMsg);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text("Submit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isPassword = false,
      bool obscureText = false,
      VoidCallback? onToggle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey),
                  onPressed: onToggle)
              : null,
        ),
      ),
    );
  }

  Widget _divider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(height: 0.5, child: Container(color: Colors.grey)));

  Widget _buildMenuRow(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return Row(
      children: [
        Icon(icon, color: primary),
        const SizedBox(width: 20),
        Expanded(child: Text(text, style: regular14.copyWith(fontSize: 14))),
        SizedBox(
            width: 40,
            child: TextButton(
                onPressed: onTap,
                child: const Icon(Icons.chevron_right_outlined))),
      ],
    );
  }
}
