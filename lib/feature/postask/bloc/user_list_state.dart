part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitialState extends UserListState {}

class UserListLoadingState extends UserListState {}

class UserListLoadedState extends UserListState {
  final List<User> users;

  const UserListLoadedState(this.users);

  @override
  List<Object> get props => [users];
}

class UserListErrorState extends UserListState {
  final String errorMessage;

  const UserListErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
