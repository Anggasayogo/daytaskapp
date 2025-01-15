import 'dart:async';
import 'package:daytaskapp/data/models/login_model.dart';
import 'package:daytaskapp/utils/exceptions/exceptions.dart';
import 'login_repo.dart';

class LoginRepoMockImpl implements LoginRepo {
  @override
  Future<LoginModel> postLogin({
    Map<String, dynamic>? query,
    required String email,
    required String password,
  }) async {
    // Simulasi delay jaringan
    await Future.delayed(const Duration(seconds: 1));

    // Simulasi kredensial login yang valid
    if (email == 'admin@gmail.com' && password == 'Password1!') {
      return LoginModel(
        status: true,
        message: 'Login successful',
        user: UserModel(
          user_id: 1,
          username: 'testuser',
          email: 'admin@gmail.com',
          phone: '1234567890',
          role_id: 1,
          avatar: '-',
        ),
        token: 'mock-token',
      );
    } else {
      // Kredensial salah
      throw RepoException('Invalid credentials');
    }
  }
}
