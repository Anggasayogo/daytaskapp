import 'package:daytaskapp/data/models/login_model.dart';

abstract class LoginRepo {
  Future<LoginModel> postLogin({
    Map<String, dynamic>? query,
    required String email,
    required String password,
  });
}
