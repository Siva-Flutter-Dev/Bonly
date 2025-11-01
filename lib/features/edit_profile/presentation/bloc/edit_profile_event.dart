import 'dart:io';

abstract class EditProfileEvent{}

class EditProfileSubmitted extends EditProfileEvent{
  final int userId;
  final String name;
  final String description;
  final File? profilePic;

  EditProfileSubmitted({required this.userId, required this.name, required this.description, required this.profilePic});
}

class EditableClick extends EditProfileEvent{}

class EditProfileImagePicked extends EditProfileEvent {
  final File? imageFile;
  EditProfileImagePicked(this.imageFile);
}