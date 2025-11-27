import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/user_list_model.dart';
import 'package:daytaskapp/data/repo/authenticate/login_repo.dart';
import 'package:equatable/equatable.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final LoginRepo loginRepo;

  UserListBloc({required this.loginRepo}) : super(UserListInitialState()) {
    on<FetchUserListEvent>(_onFetchUserList);
  }

  Future<void> _onFetchUserList(
      FetchUserListEvent event, Emitter<UserListState> emit) async {
    emit(UserListLoadingState());

    try {
      final userListResponse = await loginRepo.getUserList();

      emit(UserListLoadedState(userListResponse.users));
    } catch (e) {
      emit(UserListErrorState('Failed to fetch user list: $e'));
    }
  }
}
