import 'package:bondly/features/register_screen/domain/entities/user_entities.dart';

class UserModel extends RegisterEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });
}
