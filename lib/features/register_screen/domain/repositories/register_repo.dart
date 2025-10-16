import 'package:bondly/features/register_screen/domain/entities/user_entities.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  });
}
