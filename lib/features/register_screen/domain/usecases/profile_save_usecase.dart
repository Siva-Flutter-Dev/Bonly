import 'package:bondly/core/error/failure.dart';
import 'package:bondly/core/usecases/usecases.dart';
import 'package:bondly/features/register_screen/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/register_repo.dart';

class ProfileSaveUseCase implements UseCase<ProfileSaveEntity,ProfileSaveParam>{

  final RegisterRepository repository;

  ProfileSaveUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileSaveEntity>> call(ProfileSaveParam params) async {
    return await repository.profileSave(
      name: params.name,
      email: params.email,
      id: params.id,
    );
  }
}

class ProfileSaveParam{
  final String email;
  final String name;
  final String? id;
  ProfileSaveParam({
    required this.email,
    required this.name,
    required this.id,
  });
}