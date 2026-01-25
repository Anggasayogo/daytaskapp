import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final int userId;
  final String username;
  final String email;
  final String phone;
  final String roleId;
  final String divisiId;
  final String password;
  final File? avatar;

  UpdateProfileEvent({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.roleId,
    required this.divisiId,
    required this.password,
    this.avatar,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        phone,
        roleId,
        divisiId,
        password,
        avatar,
      ];
}
