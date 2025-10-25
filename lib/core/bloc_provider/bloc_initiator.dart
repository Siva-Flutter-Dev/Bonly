import 'package:bondly/features/login_screen/presentation/bloc/login_bloc.dart';
import 'package:bondly/features/profile_screen/presentation/bloc/profile_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/injection_container.dart' as di;
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
      create: (_) => di.sl<ProfileBloc>(),
    ),
  ];
}