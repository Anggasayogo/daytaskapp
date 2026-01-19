import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/splash/view/logocontain_view.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // default login 
   
    // Delayed navigation after splash screen is shown
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        final isLogin = await getToken();
        print("Token "+isLogin.toString());
        if(isLogin == null) {
          context.goNamed(RoutePath.login); 
        } else {
          context.goNamed(RoutePath.home);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const LogoContain(),
      ),
    );
  }
}
