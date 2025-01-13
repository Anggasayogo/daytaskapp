import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoContain extends StatelessWidget {
  const LogoContain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/logo.svg', width: 131, height: 131)
          ],
        ),
    );
  }
}