abstract class EditProfileState{
  final bool isEditProfileClicked;
  EditProfileState({required this.isEditProfileClicked});
}

class EditProfileInitial extends EditProfileState{
  EditProfileInitial({required super.isEditProfileClicked});
}

class EditProfileLoading extends EditProfileState{
  EditProfileLoading({required super.isEditProfileClicked});
}

class EditProfileSuccess extends EditProfileState{
  EditProfileSuccess({required super.isEditProfileClicked});
}

class EditProfileFailure extends EditProfileState{
  final String message;
  EditProfileFailure({required this.message, required super.isEditProfileClicked});
}