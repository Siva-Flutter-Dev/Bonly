import 'dart:io';

import 'package:bondly/core/error/failure.dart';
import 'package:bondly/core/usecases/usecases.dart';
import 'package:bondly/features/edit_profile/domain/entities/edit_profile_entity.dart';
import 'package:bondly/features/edit_profile/domain/repository/edit_profile_repository.dart';
import 'package:dartz/dartz.dart';

class EditProfileCase extends UseCase<EditProfileEntity, EditProfileParams>{
  final EditProfileRepository repository;
  EditProfileCase(this.repository);
  @override
  Future<Either<Failure, EditProfileEntity>> call(EditProfileParams params) async{
    return await repository.editProfileInfo(
      name: params.name,
      description: params.description,
      profilePic: params.profileUrl,
      userId: params.userId,
    );
  }
}

class EditProfileParams {
  final int userId;
  final String name;
  final String description;
  final File? profileUrl;

  EditProfileParams({
    required this.userId,
    required this.name,
    required this.description,
    required this.profileUrl,
  });
}