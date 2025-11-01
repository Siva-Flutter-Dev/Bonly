import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repo.dart';
import '../datasources/login_datasources.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.loginUser(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
