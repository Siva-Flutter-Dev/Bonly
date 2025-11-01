import 'package:bondly/features/edit_profile/domain/entities/edit_profile_entity.dart';

class EditProfileInfoModel extends EditProfileEntity {
  const EditProfileInfoModel({
    required super.name,
    required super.description,
    required super.profilePic,
    required super.id,
  });
}
