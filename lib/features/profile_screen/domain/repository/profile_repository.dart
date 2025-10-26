import '../entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<String> uploadProfileImage(String filePath);
  Future<void> updateProfileImage({required String rowId, required String fileId});
  Future<void> logOutUser();
}
