import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  Card(
                    color: Colors.white,
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 40, left: 15, right: 15),
                      child: Row(children: [
                        Image.asset('assets/images/profile.png',
                            width: 50, height: 50, fit: BoxFit.fill),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSuccessState) {
                                final username = state.loginModel.user.username; 
                                final email = state.loginModel.user.email;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(username,
                                        style: semibold12_5.copyWith(fontSize: 16)),
                                    Text(email,
                                        style: regular14.copyWith(fontSize: 9))
                                  ],
                                );
                              }else{
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Username',
                                        style: semibold12_5.copyWith(fontSize: 16)),
                                    Text('email@gmail.com',
                                        style: regular14.copyWith(fontSize: 13))
                                  ],
                                );
                              }
                            }
                          )
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                            onPressed: () {}, child: const Icon(Icons.edit))
                      ]),
                    ),
                  ),
                  const SizedBox(height: 40),
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
                            Row(children: [
                              Icon(Icons.receipt_long_outlined, color: primary),
                              const SizedBox(width: 20),
                              Expanded(
                                  flex: 1,
                                  child: Text('Download Report',
                                      style: regular14.copyWith(fontSize: 14))),
                              SizedBox(
                                width: 40, // Atur lebar sesuai kebutuhan
                                child: TextButton(
                                  onPressed: () {
                                    context.push(RoutePath.report);
                                  },
                                  child:
                                      const Icon(Icons.chevron_right_outlined),
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                height: 0.5,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Row(children: [
                              Icon(Icons.privacy_tip_outlined, color: primary),
                              const SizedBox(width: 20),
                              Expanded(
                                  flex: 1,
                                  child: Text('Kebijakan Privasi',
                                      style: regular14.copyWith(fontSize: 14))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 40, // Atur lebar sesuai kebutuhan
                                child: TextButton(
                                  onPressed: () {},
                                  child: Icon(Icons.chevron_right_outlined),
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                height: 0.5,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Row(children: [
                              Icon(Icons.logout_outlined, color: primary),
                              const SizedBox(width: 20),
                              Expanded(
                                  flex: 1,
                                  child: Text('Logout',
                                      style: regular14.copyWith(fontSize: 14))),
                              SizedBox(
                                width: 40, // Atur lebar sesuai kebutuhan
                                child: TextButton(
                                  onPressed: () {
                                    context.go(RoutePath.login);
                                  },
                                  child: const Icon(Icons.chevron_right_outlined),
                                ),
                              ),
                            ]),
                          ],
                        )),
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
}
