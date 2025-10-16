import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> loginUser({
    required String email,
    required String password,
  });
}
