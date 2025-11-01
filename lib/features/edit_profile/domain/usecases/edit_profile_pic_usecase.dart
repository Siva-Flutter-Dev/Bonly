import 'dart:io';

import 'package:bondly/core/error/failure.dart';
import 'package:bondly/core/usecases/usecases.dart';
import 'package:bondly/features/edit_profile/domain/repository/edit_profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/edit_profile_pic_entity.dart';

class EditProfilePicCase extends UseCase<EditProfilePicEntity, EditProfilePicParams>{
  final EditProfileRepository repository;
  EditProfilePicCase(this.repository);
  @override
  Future<Either<Failure, EditProfilePicEntity>> call(EditProfilePicParams params) async{
    return await repository.editProfilePicture(
        file: params.file
    );
  }
}

class EditProfilePicParams {
  final File file;

  EditProfilePicParams({
    required this.file,
  });
}