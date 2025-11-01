import 'dart:io';

class EditProfilePicEntity {
  final String id;
  final File file;

  const EditProfilePicEntity({
    required this.id,
    required this.file,
  });
}