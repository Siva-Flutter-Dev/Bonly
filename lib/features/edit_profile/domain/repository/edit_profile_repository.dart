import 'dart:io';

import 'package:bondly/features/edit_profile/domain/entities/edit_profile_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/edit_profile_pic_entity.dart';

abstract class EditProfileRepository{
  Future<Either<Failure, EditProfileEntity>> editProfileInfo({
    required int userId,
    required String name,
    required String description,
    required File? profilePic,
  });
  Future<Either<Failure, EditProfilePicEntity>> editProfilePicture({
    required File file,
  });
}