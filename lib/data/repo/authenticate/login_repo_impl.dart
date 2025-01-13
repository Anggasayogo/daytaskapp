import 'package:daytaskapp/data/models/login_model.dart';
import 'package:daytaskapp/data/repo/authenticate/login_repo.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/utils/exceptions/exceptions.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  // Konstruktor untuk menerima ApiService
  LoginRepoImpl({required this.apiService});

  @override
  Future<LoginModel> postLogin({
    Map<String, dynamic>? query,
    required String email,
    required String password,
  }) async {
    try {
      String url = ApiPath.v1 + ApiPath.login;
      final response = await apiService.post(
        path: url,
        data: {
          'email': email,
          'password': password,
        },
        query: query,
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw RepoException("Failed to log in: ${response.statusCode}");
      }
    } catch (e) {
      throw RepoException("Error while logging in: $e");
    }
  }
}
