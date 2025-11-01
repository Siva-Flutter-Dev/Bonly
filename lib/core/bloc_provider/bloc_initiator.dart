import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bondly/features/login_screen/presentation/bloc/login_bloc.dart';
import 'package:bondly/features/profile_screen/presentation/bloc/profile_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/injection_container.dart' as di;
import '../../features/profile_screen/domain/usecase/logout.dart';
import '../../features/profile_screen/domain/usecase/profile_usecase.dart';
import '../../features/profile_screen/domain/usecase/update_profile_usecase.dart';
import '../../features/profile_screen/domain/usecase/upload_profile_usecase.dart';
import '../../features/profile_screen/presentation/bloc/profile_event.dart';
import '../../features/register_screen/presentation/bloc/register_bloc.dart';

class BlocInit{
  static List<SingleChildWidget> provider = [
    BlocProvider<RegisterBloc>(
      create: (_) => di.sl<RegisterBloc>(),
    ),
    BlocProvider<LoginBloc>(
      create: (_) => di.sl<LoginBloc>(),
    ),
    BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(
        getProfile: di.sl<GetProfile>(),
        uploadProfileImage: di.sl<UploadProfileImage>(),
        updateProfileImage: di.sl<UpdateProfileImage>(),
        logOutButton: di.sl<LogOutButton>(),
      )..add(ProfileFetched()),
    ),
    BlocProvider<EditProfileBloc>(
      create: (_) => di.sl<EditProfileBloc>(),
    )
  ];
}