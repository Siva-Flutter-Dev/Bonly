abstract class ProfileEvent {}

class ProfileFetched extends ProfileEvent {}

class ProfileImageUploaded extends ProfileEvent {
  final String filePath;

  ProfileImageUploaded({required this.filePath});
}
