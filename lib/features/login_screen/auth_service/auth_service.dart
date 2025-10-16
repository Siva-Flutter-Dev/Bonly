import 'package:appwrite/appwrite.dart';
import 'package:bondly/core/constants/app_constants.dart';
import 'package:bondly/data/services/store_user_data.dart';
import '../../../core/network/network_info.dart';
import '../../../data/services/environment.dart';

class AuthService {
  late final Client client;
  late final Account account;
  final NetworkInfo networkInfo;

  AuthService({required this.networkInfo}) {
    client = Client()
      ..setEndpoint(Environment.appwritePublicEndpoint)
      ..setProject(Environment.appwriteProjectId);

    account = Account(client);
  }

  Future<void> login({required String email, required String password}) async {
    var storeUserData = StoreUserData();
    final connected = await networkInfo.isConnected;

    if (!connected) {
      throw Exception('No Internet connection');
    }
    try {
      print("===========");
      print("Network :$connected");
      final currentUser = await account.get();
      print(currentUser.name);
      storeUserData.setBoolean(AppConstants.loginSession, true);
      storeUserData.setString(AppConstants.userName, currentUser.name);
      storeUserData.setString(AppConstants.userEmail, currentUser.email);
      storeUserData.setString(AppConstants.userId, currentUser.$id);
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        print("=======401");
        final session = await account.createEmailPasswordSession(email: email, password: password);
        storeUserData.setBoolean(AppConstants.loginSession, true);
        storeUserData.setString(AppConstants.userName, email.split('@').first);
        storeUserData.setString(AppConstants.userEmail, email);
        storeUserData.setString(AppConstants.userId, session.$id);
        print(session.$id);
      } else {
        throw Exception(e.message ?? 'Login error');
      }
    }
  }


}
