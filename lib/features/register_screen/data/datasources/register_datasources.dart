

import '../../auth_service/auth_service.dart';
import '../model/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<UserModel> registerUser({
    required String name,
    required String email,
    required String password,
  });
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final RegisterService registerService;

  RegisterRemoteDataSourceImpl({required this.registerService});

  @override
  Future<UserModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    await registerService.register(
      email: email,
      password: password,
      name: name,
    );

    return UserModel(
      id: 'N/A',
      name: name,
      email: email,
    );
  }
}
