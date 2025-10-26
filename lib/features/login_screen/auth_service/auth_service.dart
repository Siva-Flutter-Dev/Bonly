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
      print("===========");
      print("Network: $connected");

      // 1️⃣ Check if a session already exists
      final currentSession = supabase.auth.currentSession;
      final currentUser = supabase.auth.currentUser;

      if (currentSession != null && currentUser != null) {
        print("User already logged in: ${currentUser.email}");
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
      print("✅ Login successful: ${user.email}");
    } on AuthException catch (e) {
      print("❌ Auth error: ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      print("❌ Unexpected error: $e");
      throw Exception('Unexpected login error');
    }
  }

  Future<void> _storeUserData(
      StoreUserData storeUserData,
      User user,
      ) async {
    await storeUserData.setBoolean(AppConstants.loginSession, true);
    await storeUserData.setString(
      AppConstants.userName,
      user.userMetadata?['name'] ?? user.email?.split('@').first ?? '',
    );
    await storeUserData.setString(AppConstants.userEmail, user.email ?? '');
    await storeUserData.setString(AppConstants.userId, user.id);
  }
}
