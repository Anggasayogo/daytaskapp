import 'dart:io';

import 'package:daytaskapp/data/models/update_profile_response.dart';
import 'package:daytaskapp/data/repo/profile/profile_repo.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService apiService;

  ProfileRepoImpl({required this.apiService});

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
    try {
      final url = '${ApiPath.v1}/auth/user/update/$userId';

      final formData = FormData();

      formData.fields.addAll([
        MapEntry('username', username),
        MapEntry('email', email),
        MapEntry('phone', phone),
        MapEntry('role_id', roleId),
        MapEntry('divisi_id', divisiId),
      ]);

      if (password != null && password.isNotEmpty) {
        formData.fields.add(MapEntry('password', password));
      }

      // 🔥 AVATAR FIX MIME TYPE
      if (avatar != null) {
        final fileName = avatar.path.split('/').last;
        final ext = fileName.split('.').last.toLowerCase();

        MediaType mediaType;
        if (ext == 'png') {
          mediaType = MediaType('image', 'png');
        } else {
          mediaType = MediaType('image', 'jpeg'); // jpg & jpeg
        }

        formData.files.add(
          MapEntry(
            'avatar',
            await MultipartFile.fromFile(
              avatar.path,
              filename: fileName,
              contentType: mediaType, // 🔥 INI KUNCI
            ),
          ),
        );
      }

      final response = await apiService.put(
        path: url,
        data: formData,
      );

      if (response.statusCode == 200) {
        return UpdateProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}
