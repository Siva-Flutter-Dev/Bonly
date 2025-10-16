import 'package:bondly/features/login_screen/auth_service/auth_service.dart';
import 'package:bondly/features/register_screen/auth_service/auth_service.dart';
import 'package:bondly/features/register_screen/data/datasources/register_datasources.dart';
import 'package:bondly/features/register_screen/data/repository/register_repository_impl.dart';
import 'package:bondly/features/register_screen/domain/repositories/register_repo.dart';
import 'package:bondly/features/register_screen/domain/usecases/register_usecase.dart';
import 'package:bondly/features/register_screen/presentation/bloc/register_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../core/network/network_info.dart';
import 'login_screen/data/datasources/login_datasources.dart';
import 'login_screen/data/repository/login_repository_impl.dart';
import 'login_screen/domain/repositories/login_repo.dart';
import 'login_screen/domain/usecases/login_usecases.dart';
import 'login_screen/presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

void coreInit(){
  // Network
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectivity: Connectivity()),
  );
}

void registerInit() {
  // RegisterService with network check
  sl.registerLazySingleton(() => RegisterService(networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSourceImpl(registerService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Bloc
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));
}

void loginInit() {
  // RegisterService with network check
  sl.registerLazySingleton(() => AuthService(networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(loginService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));

  // Bloc
  sl.registerFactory(() => LoginBloc(loginUser: sl()));
}

