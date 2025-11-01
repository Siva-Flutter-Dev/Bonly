import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bondly/core/constants/app_constants.dart';
import 'package:bondly/data/services/store_user_data.dart';
import '../../../core/network/network_info.dart';
import '../../../data/services/environment.dart';

class AuthService {
  late final SupabaseClient supabase;
  final NetworkInfo networkInfo;

  AuthService({required this.networkInfo}) {
    supabase = SupabaseClient(
      Environment.supabaseUrl,
      Environment.supabaseAnonKey,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final storeUserData = StoreUserData();
    final connected = await networkInfo.isConnected;

    if (!connected) {
      throw Exception('No Internet connection');
    }

    try {

      // 1️⃣ Check if a session already exists
      final currentSession = supabase.auth.currentSession;
      final currentUser = supabase.auth.currentUser;

      if (currentSession != null && currentUser != null) {
        await _storeUserData(storeUserData, currentUser);
        return;
      }

      // 2️⃣ No session → perform login
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception('Login failed — user is null');
      }

      await _storeUserData(storeUserData, user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected login error');
    }
  }

  Future<void> _storeUserData(
      StoreUserData storeUserData,
      User user,
      ) async {
    storeUserData.setBoolean(AppConstants.loginSession, true);
    storeUserData.setString(
      AppConstants.userName,
      user.userMetadata?['name'] ?? user.email?.split('@').first ?? '',
    );
    storeUserData.setString(AppConstants.userEmail, user.email ?? '');
    storeUserData.setString(AppConstants.userId, user.id);
  }
}
