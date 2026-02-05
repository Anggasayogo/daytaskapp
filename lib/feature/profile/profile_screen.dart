import 'package:daytaskapp/app/config/server_config.dart';
import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Load avatar dari SharedPreferences
  Future<String?> _loadAvatar() async {
    return await getAvatar();
  }

  // Load username dari SharedPreferences
  Future<String?> _loadUsername() async {
    return await getUsername();
  }

  Future<String?> _loadEmail() async {
    return await getEmail();
  }

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
                  // Profile Card (Avatar + Username + Email + Edit Button)
                  Card(
                    color: Colors.white,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 40, left: 15, right: 15),
                      child: Row(
                        children: [
                          // Avatar
                          FutureBuilder<String?>(
                            future: _loadAvatar(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
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
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          // Username + Email
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<String?>(
                              future: _loadUsername(),
                              builder: (context, snapshot) {
                                final username = snapshot.data ?? "Username";
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(username,
                                        style: semibold12_5.copyWith(
                                            fontSize: 16)),
                                    FutureBuilder<String?>(
                                      future: _loadEmail(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Indikator loading kecil agar tidak merusak layout
                                          return const SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          );
                                        }

                                        // Ambil data dari snapshot, jika null tampilkan default
                                        final email =
                                            snapshot.data ?? "email@gmail.com";

                                        return Text(
                                          email,
                                          style: regular14.copyWith(
                                            fontSize: 13,
                                            color: Colors.grey
                                                .shade600, // Tambahkan warna abu agar lebih estetik
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Edit button
                          TextButton(
                            onPressed: () {
                              context.pushNamed(RoutePath.detail_profile);
                            },
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Menu Card
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 15, right: 15),
                      child: Column(
                        children: [
                          _buildMenuRow(
                            icon: Icons.receipt_long_outlined,
                            text: 'Download Report',
                            onTap: () => context.push(RoutePath.report),
                          ),
                          _divider(),
                          _buildMenuRow(
                            icon: Icons.card_giftcard,
                            text: 'Reward Saya',
                            onTap: () => context.push(RoutePath.reward_list),
                          ),
                          _divider(),
                          _buildMenuRow(
                            icon: Icons.privacy_tip_outlined,
                            text: 'Kebijakan Privasi',
                            onTap: () {},
                          ),
                          _divider(),
                          _buildMenuRow(
                            icon: Icons.logout_outlined,
                            text: 'Logout',
                            onTap: () async {
                              await clearRoleId();
                              await clearToken();
                              await clearUserId();
                              context.go(RoutePath.login);
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

  // Divider antara menu
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 0.5,
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }

  // Widget baris menu
  Widget _buildMenuRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Icon(icon, color: primary),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: regular14.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextButton(
            onPressed: onTap,
            child: const Icon(Icons.chevron_right_outlined),
          ),
        ),
      ],
    );
  }
}
