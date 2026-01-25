import 'package:daytaskapp/data/repo/profile/profile_repo.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo repo;

  ProfileBloc({required this.repo}) : super(ProfileInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final response = await repo.updateProfile(
        userId: event.userId,
        username: event.username,
        email: event.email,
        phone: event.phone,
        roleId: event.roleId,
        divisiId: event.divisiId,
        password: event.password,
        avatar: event.avatar,
      );

      // ================= SAVE UPDATED USER =================
      final user = response.data; // ⬅️ SESUAIKAN DENGAN MODEL

      if (user.avatar != null) {
        await saveUsername(user.username);
        await saveAvatar(
          "${user.avatar}",
        );
      }

      emit(ProfileSuccess(response));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
