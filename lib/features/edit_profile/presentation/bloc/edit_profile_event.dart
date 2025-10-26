import 'dart:io';

abstract class EditProfileEvent{}

class EditProfileSubmitted extends EditProfileEvent{
  final String name;
  final String description;
  final File profilePic;

  EditProfileSubmitted({required this.name, required this.description, required this.profilePic});
}

class EditableClick extends EditProfileEvent{}