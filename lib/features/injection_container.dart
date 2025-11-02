import 'package:bondly/features/blog_page/data/repository_impl/blog_repository_impl.dart';
import 'package:bondly/features/blog_page/data/service/blog_service.dart';
import 'package:bondly/features/blog_page/domain/repository/blog_repository.dart';
import 'package:bondly/features/blog_page/domain/usecases/blog_usecase.dart';
import 'package:bondly/features/blog_page/presentation/bloc/blog_bloc.dart';
import 'package:bondly/features/edit_profile/data/repository_impl/edit_profile_repository_impl.dart';
import 'package:bondly/features/edit_profile/data/service/edit_profile_service.dart';
import 'package:bondly/features/edit_profile/domain/repository/edit_profile_repository.dart';
import 'package:bondly/features/edit_profile/domain/usecases/edit_profile_pic_usecase.dart';
import 'package:bondly/features/edit_profile/domain/usecases/edit_profile_use_case.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bondly/features/login_screen/auth_service/auth_service.dart';
import 'package:bondly/features/profile_screen/data/repository/profile_repository_impl.dart';
import 'package:bondly/features/profile_screen/data/service/profile_services.dart';
import 'package:bondly/features/profile_screen/domain/repository/profile_repository.dart';
import 'package:bondly/features/profile_screen/domain/usecase/logout.dart';
import 'package:bondly/features/profile_screen/domain/usecase/profile_usecase.dart';
import 'package:bondly/features/profile_screen/domain/usecase/update_profile_usecase.dart';
import 'package:bondly/features/profile_screen/domain/usecase/upload_profile_usecase.dart';
import 'package:bondly/features/profile_screen/presentation/bloc/profile_bloc.dart';
import 'package:bondly/features/register_screen/auth_service/auth_service.dart';
import 'package:bondly/features/register_screen/data/datasources/register_datasources.dart';
import 'package:bondly/features/register_screen/data/repository/register_repository_impl.dart';
import 'package:bondly/features/register_screen/domain/repositories/register_repo.dart';
import 'package:bondly/features/register_screen/domain/usecases/profile_save_usecase.dart';
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
  /// Network
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectivity: Connectivity()),
  );
}

void registerInit() {
  /// RegisterService with network check
  sl.registerLazySingleton(() => RegisterService(networkInfo: sl()));

  /// Data sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSourceImpl(registerService: sl()),
  );

  /// Repositories
  sl.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(remoteDataSource: sl()),
  );

  /// Use cases
  sl.registerLazySingleton(() => RegisterUser(sl()));

  /// Bloc
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

void profileInit(){
  // PROFILE FEATURE

// Service
  sl.registerLazySingleton(() => ProfileService(networkInfo: sl()));

// Repository
  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl()),
  );

// UseCases
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton(() => UploadProfileImage(sl()));
  sl.registerLazySingleton(() => UpdateProfileImage(sl()));
  sl.registerLazySingleton(() => LogOutButton(sl()));

// Bloc
  sl.registerFactory(() => ProfileBloc(
    getProfile: sl(),
    uploadProfileImage: sl(),
    updateProfileImage: sl(),
    logOutButton: sl(),
  ));

}

void editProfileInit(){
  // PROFILE FEATURE

// Service
  sl.registerLazySingleton(() => EditProfileService(networkInfo: sl()));

// Repository
  sl.registerLazySingleton<EditProfileRepository>(
        () => EditProfileRepositoryImpl(sl()),
  );

// UseCases
  sl.registerLazySingleton(() => EditProfileCase(sl()));
  sl.registerLazySingleton(() => EditProfilePicCase(sl()));
//   sl.registerLazySingleton(() => UpdateProfileImage(sl()));
//   sl.registerLazySingleton(() => LogOutButton(sl()));

// Bloc
  sl.registerFactory(() => EditProfileBloc(
      editProfileCase: sl()
  ));

}

void blogInit(){

// Service
  sl.registerLazySingleton(() => BlogService(networkInfo: sl()));

// Repository
  sl.registerLazySingleton<BlogRepository>(
        () => BlogRepositoryImpl(sl()),
  );

// UseCases
  sl.registerLazySingleton(() => GetBlogs(sl()));

// Bloc
  sl.registerFactory(() => BlogBloc(getBlogs: sl()));

}

