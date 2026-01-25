import 'package:daytaskapp/data/models/update_profile_response.dart';
import 'dart:io';

abstract class ProfileRepo {
  Future<UpdateProfileResponse> updateProfile({
    required int userId,
    required String username,
    required String email,
    required String phone,
    required String roleId,
    required String divisiId,
    File? avatar,
    String? password,
  });
}
