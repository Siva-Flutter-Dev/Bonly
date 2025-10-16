import 'package:appwrite/appwrite.dart';
import '../../../core/network/network_info.dart';
import '../../../data/services/environment.dart';

class RegisterService {
  late final Client client;
  late final Account account;
  final NetworkInfo networkInfo;

  RegisterService({required this.networkInfo}) {
    client = Client()
      ..setEndpoint(Environment.appwritePublicEndpoint)
      ..setProject(Environment.appwriteProjectId);

    account = Account(client);
  }
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final connected = await networkInfo.isConnected;

    if (!connected) {
      throw Exception('No Internet connection');
    }
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      print('User registered successfully');
    } on AppwriteException catch (e) {
      print('Registration failed: ${e.message}');
      throw Exception(e.message ?? 'Registration failed');
    }
  }


}
