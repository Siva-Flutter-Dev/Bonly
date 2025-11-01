import 'dart:io';

import 'package:bondly/features/edit_profile/data/service/edit_profile_service.dart';
import 'package:bondly/features/edit_profile/domain/entities/edit_profile_entity.dart';
import 'package:bondly/features/edit_profile/domain/entities/edit_profile_pic_entity.dart';
import 'package:bondly/features/edit_profile/domain/repository/edit_profile_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileService remoteDataSource;

  EditProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, EditProfileEntity>> editProfileInfo({required String name, required String description, required File? profilePic,required int userId}) async{
    try {
      final userDetails = await remoteDataSource.updateUserInfo(
        name: name,
        description: description,
        userId: userId,
        filePath: profilePic,
      );
      return Right(userDetails);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditProfilePicEntity>> editProfilePicture({required File file}) {
    // TODO: implement editProfilePicture
    throw UnimplementedError();
  }
}
