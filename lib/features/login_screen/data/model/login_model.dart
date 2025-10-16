import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.id,
    required super.email,
    required super.password,
  });
}
