
import '../repository/profile_repository.dart';

class UploadProfileImage {
  final ProfileRepository repository;

  UploadProfileImage(this.repository);

  Future<String> call(String filePath) async {
    return await repository.uploadProfileImage(filePath);
  }
}
