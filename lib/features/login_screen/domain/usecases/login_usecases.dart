import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repo.dart';

class LoginUser implements UseCase<LoginEntity, LoginParams> {
  final LoginRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    print("Domain Repository=====Success++O");
    print("===========");
    print(params);
    return await repository.loginUser(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
