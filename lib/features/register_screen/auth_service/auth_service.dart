import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/network_info.dart';
import '../../../data/services/environment.dart';

class RegisterService {
  final NetworkInfo networkInfo;
  late final SupabaseClient supabase;

  RegisterService({required this.networkInfo}) {
    supabase = SupabaseClient(
      Environment.supabaseUrl,
      Environment.supabaseAnonKey,
    );
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
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user != null) {
        print('✅ User registered successfully: ${response.user!.email}');
      } else {
        print('⚠️ Registration returned null user');
      }
    } on AuthException catch (e) {
      print('❌ Registration failed: ${e.message}');
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw Exception('Registration failed');
    }
  }
}
