import '../repository/profile_repository.dart';

class LogOutButton {
  final ProfileRepository repository;

  LogOutButton(this.repository);

  Future<void> call() async {
    return await repository.logOutUser();
  }
}
