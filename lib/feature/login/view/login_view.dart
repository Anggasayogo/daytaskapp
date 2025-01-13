import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  final Function(String email, String password) onSubmit;

  const LoginView({super.key, required this.onSubmit});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true; // Status visibilitas password
  
  @override
  void initState() {
    emailController.text = "anggasayogosm@gmail.com";
    passwordController.text = "12345678";
  }


  @override
  void dispose() {
    emailController.dispose(); // Membebaskan resource controller saat widget dihancurkan
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color:
            Colors.white, // Mengatur warna latar belakang tubuh menjadi putih
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Menyusun anak-anak widget ke kiri
          children: [
            Text(
              'E-mail',
              style: semibold12_5.copyWith(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Masukkan email Anda',
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Kata Sandi',
              style: semibold12_5.copyWith(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Masukkan kata sandi Anda',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Menyembunyikan/memperlihatkan password
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: double.infinity, // Membuat tombol memanjang penuh
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                bool isLoading = state is LoginLoadingState;

                return TextButton(
                  onPressed: isLoading ? null : () {
                    // Validasi sebelum mengirim data
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Email dan password tidak boleh kosong')),
                      );
                      return;
                    }

                    // Menyampaikan email dan password ke onSubmit
                    widget.onSubmit(
                        emailController.text, passwordController.text);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        primary, // Warna hijau yang telah didefinisikan
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Menyesuaikan radius sesuai kebutuhan
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text(
                          'Masuk',
                          style: semibold14.copyWith(
                              fontSize: 16, color: Colors.white),
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
