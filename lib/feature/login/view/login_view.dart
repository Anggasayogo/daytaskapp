import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';
import 'package:daytaskapp/feature/login/widgets/configformdata.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_captcha/local_captcha.dart';

class LoginView extends StatefulWidget {
  final Function(String email, String password) onSubmit;

  const LoginView({super.key, required this.onSubmit});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  bool _obscureText = true; // Status visibilitas password

  final LocalCaptchaController _captchaController = LocalCaptchaController();
  final ConfigFormData _captchaConfig = ConfigFormData();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    captchaController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context, bool isLoading) {
    if (isLoading) return;

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password tidak boleh kosong'),
        ),
      );
      return;
    }

    if (captchaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('captcha tidak boleh kosong'),
        ),
      );

      captchaController.clear();
      _captchaController.refresh();
      return;
    }

    final captchaResult = _captchaController.validate(captchaController.text);
   
    if (captchaResult != LocalCaptchaValidation.valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('captcha tidak valid!')),
      );

      captchaController.clear();
      _captchaController.refresh();
      return;
    }

    widget.onSubmit(
      emailController.text,
      passwordController.text,
    );
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
                hintText: 'Input email',
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
                hintText: 'Input Password',
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
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // 👈 radius di sini
              child: LocalCaptcha(
                controller: _captchaController,
                height: 60,
                width: MediaQuery.of(context).size.width,
                backgroundColor: Colors.grey.shade200,
                chars: _captchaConfig.chars,
                length: _captchaConfig.length,
                fontSize: _captchaConfig.fontSize > 0
                    ? _captchaConfig.fontSize
                    : null,
                caseSensitive: _captchaConfig.caseSensitive,
                codeExpireAfter: _captchaConfig.codeExpireAfter,
                onCaptchaGenerated: (code) {
                  debugPrint('Captcha generated: $code');
                },
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: captchaController,
              decoration: InputDecoration(
                hintText: 'Input captcha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    captchaController.clear();
                    _captchaController.refresh();
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity, // Membuat tombol memanjang penuh
              child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                bool isLoading = state is LoginLoadingState;

                return TextButton(
                  onPressed: isLoading ? null : () {
                    // Validasi sebelum mengirim data
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Email dan password tidak boleh kosong')),
                      );
                      return;
                    }

                    _onLoginPressed(context, isLoading);
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
