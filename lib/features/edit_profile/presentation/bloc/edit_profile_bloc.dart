import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/edit_profile_use_case.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  EditProfileCase editProfileCase;
  EditProfileBloc({required this.editProfileCase}) : super(EditProfileInitial(isEditProfileClicked: false, selectedImageFile: null)) {
    on<EditProfileSubmitted>(_editProfile);
    on<EditableClick>(_editableProfile);
    on<EditProfileImagePicked>(_selectProfileImage);
  }

  Future<void> _editProfile(EditProfileSubmitted event,Emitter<EditProfileState> emit)async{
    emit(EditProfileLoading(isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: state.selectedImageFile));
    final result = await editProfileCase(EditProfileParams(
        name: event.name,
        description: event.description,
        profileUrl: event.profilePic,
      userId:event.userId
    ));
    result.fold(
          (failure) => emit(EditProfileFailure(isEditProfileClicked:state.isEditProfileClicked,message: "Invalid Email or Password", selectedImageFile: state.selectedImageFile)),
          (r) => emit(EditProfileSuccess(isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: state.selectedImageFile)),
    );
    emit(EditProfileSuccess(isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: state.selectedImageFile));
  }

  Future<void> _editableProfile(EditableClick event, Emitter<EditProfileState> emit)async {
    final clicked = !state.isEditProfileClicked;
    if(state is EditProfileInitial){
      emit(EditProfileInitial(isEditProfileClicked: clicked, selectedImageFile: state.selectedImageFile));
    }else if(state is EditProfileLoading){
      emit(EditProfileLoading(isEditProfileClicked: clicked, selectedImageFile: state.selectedImageFile));
    }else if(state is EditProfileSuccess){
      emit(EditProfileSuccess(isEditProfileClicked: clicked, selectedImageFile: state.selectedImageFile));
    }else{
      emit(EditProfileFailure(message:(state as EditProfileFailure).message,isEditProfileClicked: clicked, selectedImageFile: state.selectedImageFile));
    }
  }

  Future<void> _selectProfileImage(EditProfileImagePicked event, Emitter<EditProfileState> emit)async {
    final imageFile = event.imageFile;
    if(state is EditProfileInitial){
      emit(EditProfileInitial(isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: imageFile));
    }else if(state is EditProfileLoading){
      emit(EditProfileLoading(isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: imageFile));
    }else if(state is EditProfileSuccess){
      emit(EditProfileSuccess(isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: imageFile));
    }else{
      emit(EditProfileFailure(message:(state as EditProfileFailure).message,isEditProfileClicked: state.isEditProfileClicked, selectedImageFile: imageFile));
    }
  }
}