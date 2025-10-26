import 'package:bondly/features/profile_screen/presentation/bloc/profile_event.dart';
import 'package:bondly/features/profile_screen/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/logout.dart';
import '../../domain/usecase/profile_usecase.dart';
import '../../domain/usecase/update_profile_usecase.dart';
import '../../domain/usecase/upload_profile_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UploadProfileImage uploadProfileImage;
  final UpdateProfileImage updateProfileImage;
  final LogOutButton logOutButton;

  ProfileBloc({
    required this.getProfile,
    required this.uploadProfileImage,
    required this.updateProfileImage,
    required this.logOutButton,
  }) : super(ProfileInitial()) {
    on<ProfileFetched>(_onProfileFetched);
    on<ProfileImageUploaded>(_onProfileImageUploaded);
    on<LogOutEvent>(_logOutAccount);
  }

  Future<void> _onProfileFetched(
      ProfileFetched event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    try {
      final profile = await getProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onProfileImageUploaded(
      ProfileImageUploaded event,
      Emitter<ProfileState> emit,
      ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      try {
        final fileId = await uploadProfileImage(event.filePath);
        await updateProfileImage(rowId: currentState.profile.id, fileId: fileId);
        add(ProfileFetched());
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    }
  }

  Future<void> _logOutAccount(LogOutEvent event,Emitter<ProfileState> emit)async{
    emit(ProfileLoading());
    try {
      await logOutButton();
      emit(LogOutState());
    } catch (e) {
      emit(ProfileInitial());
    }
  }
}
