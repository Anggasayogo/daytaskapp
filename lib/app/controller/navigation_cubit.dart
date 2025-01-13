import 'package:bloc/bloc.dart';
import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:equatable/equatable.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: RoutePath.home, index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(bottomNavItems: RoutePath.home,index:  0));
        break;
      case 1:
        emit(const NavigationState(bottomNavItems: RoutePath.schedule,index:  1));
        break;
      case 2:
        emit(const NavigationState(bottomNavItems: RoutePath.postask,index:  2));
        break;
      case 3:
        emit(const NavigationState(bottomNavItems: RoutePath.rank,index:  3));
        break;
      case 4:
        emit(const NavigationState(bottomNavItems: RoutePath.profile,index:  4));
        break;
    }
  }
}