import 'package:flutter/cupertino.dart';

class NamedNavigationBarItemWidget extends BottomNavigationBarItem {
  final String initialLocation;

  NamedNavigationBarItemWidget({
    required this.initialLocation, required Widget icon, required Widget activeIcon,String? label})
      : super(icon: icon, activeIcon: activeIcon, label: label);

}