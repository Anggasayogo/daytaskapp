import 'package:bloc/bloc.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:equatable/equatable.dart';
import 'package:daytaskapp/data/models/login_model.dart';
import 'package:daytaskapp/data/repo/authenticate/login_repo.dart';
import 'package:daytaskapp/utils/exceptions/exceptions.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo;

  LoginBloc({required this.loginRepo}) : super(LoginInitialState()) {
    on<LoginFetchEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        // Panggil API untuk login
        final loginData = await loginRepo.postLogin(
          email: event.email,
          password: event.password,
        );

        if (loginData.status) {
          saveToken(loginData.token);
          saveUserId(loginData.user.user_id);
          emit(LoginSuccessState(loginData));
        } else {
          emit(LoginErrorState("Login failed: ${loginData.message}")); // Jika login gagal
        }
      } on RepoException catch (e) {
        emit(LoginErrorState("Error while logging in: ${e.message}")); // Jika terjadi exception di repo
      } catch (e) {
        emit(LoginErrorState("An unexpected error occurred: ${e.toString()}")); // Menangani error lainnya
      }
    });
  }
}
