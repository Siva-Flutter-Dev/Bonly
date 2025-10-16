import 'package:bondly/features/register_screen/domain/entities/user_entities.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/register_repo.dart';

class RegisterUser implements UseCase<RegisterEntity, RegisterParams> {
  final RegisterRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    return await repository.registerUser(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
