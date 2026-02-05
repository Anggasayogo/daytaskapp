import 'dart:io';

import 'package:daytaskapp/feature/profile/bloc/profile_bloc.dart';
import 'package:daytaskapp/feature/profile/bloc/profile_event.dart';
import 'package:daytaskapp/feature/profile/bloc/profile_state.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({super.key});

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? avatarFile;
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final avatar = await getAvatar();
    final username = await getUsername();
    final email = await getEmail();

    setState(() {
      avatarUrl = avatar;
      usernameController.text = username ?? "";
      emailController.text = email ?? "";
      // phoneController.text = ... (ambil dari pref jika ada)
    });
  }

  // ================= IMAGE PICKER =================
  Future<void> pickImage(ImageSource source) async {
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 80);

    if (image != null) {
      setState(() {
        avatarFile = File(image.path);
      });
    }
  }

  void showPickImageSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kamera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Galeri"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= SUBMIT =================
  void submit() async {
    final userIdStr = await getUserId();
    final roleId = await getRoleId();

    final userId = int.tryParse(userIdStr ?? '');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID tidak valid")),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            UpdateProfileEvent(
              userId: userId,
              username: usernameController.text,
              email: emailController.text,
              phone: phoneController.text,
              roleId: roleId.toString(),
              divisiId: "1", // Sesuaikan dengan kebutuhan divisi
              avatar: avatarFile,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.response.message),
                behavior: SnackBarBehavior.floating),
          );
          Navigator.pop(context);
        }

        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Update Profile',
            style: semibold14.copyWith(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // ================= AVATAR =================
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: avatarFile != null
                            ? FileImage(avatarFile!)
                            : (avatarUrl != null && avatarUrl!.isNotEmpty)
                                ? NetworkImage(avatarUrl!)
                                : const NetworkImage(
                                    "https://ui-avatars.com/api/?name=User",
                                  ) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: showPickImageSheet,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                buildInput(
                  label: "Username",
                  hint: "Input Username",
                  controller: usernameController,
                  validator: (v) =>
                      v!.isEmpty ? "Username tidak boleh kosong" : null,
                ),

                buildInput(
                  label: "Email",
                  hint: "Input Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v!.isEmpty) return "Email wajib diisi";
                    if (!v.contains('@')) return "Email tidak valid";
                    return null;
                  },
                ),

                buildInput(
                  label: "No. HP",
                  hint: "Input Phone Number",
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v!.isEmpty) return "Nomor HP wajib diisi";
                    if (v.length < 10) return "Nomor terlalu pendek";
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is ProfileLoading ? null : submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is ProfileLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Update Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= INPUT =================
  Widget buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: semibold12_5),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: regular14.copyWith(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
