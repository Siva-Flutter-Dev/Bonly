import '../repository/profile_repository.dart';

class UpdateProfileImage {
  final ProfileRepository repository;

  UpdateProfileImage(this.repository);

  Future<void> call({
    required String rowId,
    required String fileId,
  }) async {
    await repository.updateProfileImage(
      rowId: rowId,
      fileId: fileId,
    );
  }
}
