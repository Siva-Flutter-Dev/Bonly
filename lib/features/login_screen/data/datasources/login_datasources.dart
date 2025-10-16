import 'package:bondly/features/login_screen/data/model/login_model.dart';

import '../../auth_service/auth_service.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final AuthService loginService;

  LoginRemoteDataSourceImpl({required this.loginService});

  @override
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    await loginService.login(
      email: email,
      password: password,
    );
    print("Data Source=====Success");
    print("===========");
    print("email :$email, pass :$password");
    return LoginModel(
      id: 'N/A',
      email: email,
      password: password,
    );
  }
}
