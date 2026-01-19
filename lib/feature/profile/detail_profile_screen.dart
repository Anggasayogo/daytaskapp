import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? avatarUrl =
      "https://ui-avatars.com/api/?name=User"; // contoh avatar awal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Update Profile', 
          style: semibold14.copyWith(color: Colors.black, fontSize: 16)
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(avatarUrl!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: Implement upload foto
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Username
            const Text("Username"),
            const SizedBox(height: 6),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "username",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Email
            const Text("Email"),
            const SizedBox(height: 6),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Password
            const Text("Password"),
            const SizedBox(height: 6),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Konfirmasi password",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: simpan update profile ke API
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
