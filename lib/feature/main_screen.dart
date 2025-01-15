import 'package:daytaskapp/app/controller/navigation_cubit.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/app/shared/named_nav_bar_item_widget.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  MainScreen({Key? key, required this.screen}) : super(key: key);

  Future<List<NamedNavigationBarItemWidget>> _getTabs() async {
    // Ambil roleId dari SharedPreferences
    final roleId = await getRoleId();

    // Tentukan tabs yang akan ditampilkan berdasarkan roleId
    final List<NamedNavigationBarItemWidget> tabs = [
      NamedNavigationBarItemWidget(
        initialLocation: RoutePath.home,
        icon: SvgPicture.asset('assets/icons/ic_home_inactive.svg',
            width: 25, height: 25),
        activeIcon:
            SvgPicture.asset('assets/icons/ic_home.svg', width: 25, height: 25),
        label: 'Home',
      ),
      NamedNavigationBarItemWidget(
        initialLocation: RoutePath.schedule,
        icon: SvgPicture.asset('assets/icons/ic_calendar_inactive.svg',
            width: 25, height: 25),
        activeIcon: SvgPicture.asset('assets/icons/ic_calendar.svg',
            width: 25, height: 25),
        label: 'Schedule',
      ),
      // Menambahkan Postask hanya jika roleId == '1'
      if (roleId == '1')
        NamedNavigationBarItemWidget(
          initialLocation: RoutePath.postask,
          icon: SvgPicture.asset('assets/icons/ic_plus_inactive.svg',
              width: 40, height: 40),
          activeIcon: SvgPicture.asset('assets/icons/ic_plus.svg',
              width: 40, height: 40),
          label: 'Postask',
        ),
      NamedNavigationBarItemWidget(
        initialLocation: RoutePath.rank,
        icon: SvgPicture.asset('assets/icons/ic_rank_inactive.svg',
            width: 25, height: 25),
        activeIcon:
            SvgPicture.asset('assets/icons/ic_rank.svg', width: 25, height: 25),
        label: 'Ranking',
      ),
      NamedNavigationBarItemWidget(
        initialLocation: RoutePath.profile,
        icon: SvgPicture.asset('assets/icons/ic_profile_inactive.svg',
            width: 25, height: 25),
        activeIcon: SvgPicture.asset('assets/icons/ic_profile.svg',
            width: 25, height: 25),
        label: 'Profile',
      ),
    ];

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: FutureBuilder<List<NamedNavigationBarItemWidget>>(
        future: _getTabs(), // Mendapatkan tabs secara asinkron
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading tabs'));
          }

          final tabs = snapshot.data ?? [];

          return _buildBottomNavigation(context, tabs);
        },
      ),
    );
  }

  BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(
          BuildContext context, List<NamedNavigationBarItemWidget> tabs) =>
      BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white, // Background color of the container
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, // Shadow color
                  blurRadius: 4.0, // Shadow blur radius
                  offset: Offset(0, 1), // Position of the shadow
                ),
              ],
            ),
            child: BottomNavigationBar(
              onTap: (value) async {
                if (state.index != value) {
                  context.read<NavigationCubit>().getNavBarItem(value);
                  context.go(tabs[value].initialLocation);
                }
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.grey,
              items: tabs.map((tab) {
                return BottomNavigationBarItem(
                  icon: state.index == tabs.indexOf(tab)
                      ? tab.activeIcon
                      : tab.icon,
                  label: tab.label,
                );
              }).toList(),
              currentIndex: state.index,
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      );
}
