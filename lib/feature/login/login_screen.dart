import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/login/view/login_view.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Masuk',
            style: semibold14.copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {

            final token = state.loginModel.token; 
            print("Token: $token"); 

            context.go(RoutePath.home);
          } else if (state is LoginErrorState) {
            // Tampilkan pesan error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginView(
              onSubmit: (email, password) {
                // Mengirim event LoginFetchEvent ke LoginBloc
                context.read<LoginBloc>().add(LoginFetchEvent(email, password));
              },
            ),
            Flexible(
              flex: 0,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tidak Punya Akun ?',
                      style: semibold12_5.copyWith(
                          fontSize: 14, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(RoutePath.register); // Menavigasi ke register
                      },
                      child: Text(
                        'Daftar',
                        style:
                            semibold12_5.copyWith(fontSize: 14, color: primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
