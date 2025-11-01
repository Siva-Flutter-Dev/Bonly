import 'dart:io';

class EditProfileEntity {
  final int id;
  final String name;
  final String description;
  final File? profilePic;

  const EditProfileEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.profilePic,
  });
}