import 'dart:io';

abstract class EditProfileState{
  final bool isEditProfileClicked;
  final File? selectedImageFile;
  EditProfileState({required this.isEditProfileClicked,required this.selectedImageFile});
}

class EditProfileInitial extends EditProfileState{
  EditProfileInitial({required super.isEditProfileClicked, required super.selectedImageFile});
}

class EditProfileLoading extends EditProfileState{
  EditProfileLoading({required super.isEditProfileClicked, required super.selectedImageFile});
}

class EditProfileSuccess extends EditProfileState{
  EditProfileSuccess({required super.isEditProfileClicked, required super.selectedImageFile});
}

class EditProfileFailure extends EditProfileState{
  final String message;
  EditProfileFailure({required this.message, required super.isEditProfileClicked, required super.selectedImageFile});
}