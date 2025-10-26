
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  EditProfileBloc() : super(EditProfileInitial(isEditProfileClicked: false)) {
    on<EditProfileSubmitted>(_editProfile);
    on<EditableClick>(_editableProfile);
  }

  Future<void> _editProfile(EditProfileSubmitted event,Emitter<EditProfileState> emit)async{
    emit(EditProfileLoading(isEditProfileClicked: state.isEditProfileClicked));
    emit(EditProfileSuccess(isEditProfileClicked: state.isEditProfileClicked));
  }

  Future<void> _editableProfile(EditableClick event, Emitter<EditProfileState> emit)async {
    if(state is EditProfileInitial){
      emit(EditProfileInitial(isEditProfileClicked: true));
    }else if(state is EditProfileLoading){
      emit(EditProfileLoading(isEditProfileClicked: true));
    }else if(state is EditProfileSuccess){
      emit(EditProfileSuccess(isEditProfileClicked: true));
    }else{
      emit(EditProfileFailure(message:(state as EditProfileFailure).message,isEditProfileClicked: true));
    }
  }
}