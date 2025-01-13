import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/splash/view/logocontain_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Future.delayed(const Duration(seconds: 3), () {
        context.goNamed(RoutePath.login);
      });
    });
    
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const LogoContain(),
      ),
    );
  }
}