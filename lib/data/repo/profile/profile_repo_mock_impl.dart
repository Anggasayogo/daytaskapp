import 'dart:io';

import 'package:daytaskapp/data/models/update_profile_response.dart';
import 'package:daytaskapp/data/repo/profile/profile_repo.dart';

class ProfileRepoMockImpl implements ProfileRepo {
  @override
  Future<UpdateProfileResponse> updateProfile({
    required int userId,
    required String username,
    required String email,
    required String phone,
    required String roleId,
    required String divisiId,
    File? avatar,
    String? password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final mockResponse = {
      "status": true,
      "message": "Profile updated successfully",
      "data": {
        "id": userId,
        "username": username,
        "email": email,
        "phone": phone,
        "avatar": "https://ui-avatars.com/api/?name=$username",
        "role_id": roleId,
        "divisi_id": divisiId
      }
    };

    return UpdateProfileResponse.fromJson(mockResponse);
  }
}
