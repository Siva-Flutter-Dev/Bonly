import 'package:bondly/features/profile_screen/data/models/profile_model.dart';
import '../../domain/repository/profile_repository.dart';
import '../service/profile_services.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService service;

  ProfileRepositoryImpl(this.service);

  @override
  Future<ProfileModel> getProfile() async {
    return await service.fetchUserProfile();
  }

  @override
  Future<String> uploadProfileImage(String filePath) async {
    return await service.uploadProfileImage(filePath);
  }

  @override
  Future<void> updateProfileImage({required String rowId, required String fileId}) async {
    await service.updateUserProfileImage(rowId, fileId);
  }
}
