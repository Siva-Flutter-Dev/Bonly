import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/network_info.dart';
import '../../../data/services/environment.dart';

class RegisterService {
  final NetworkInfo networkInfo;

  RegisterService({required this.networkInfo});

  Future<String> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      throw Exception('No Internet connection');
    }

    try {
      await Supabase.initialize(
        url: Environment.supabaseUrl,
        anonKey: Environment.supabaseAnonKey,
        debug: true,
      );

      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user != null) {
        print('✅ User registered: ${response.user!.id}');
      } else if (response.session == null && response.user == null) {
        // Signup succeeded but requires email confirmation
        print('⚠️ User must confirm email. Check your inbox.');
      } else {
        throw Exception('Auth failed: ${response.session?.isExpired}');
      }


      // Insert profile
      final r = await supabase.from(Environment.profileTable).insert({
        'name': name,
        'email': email,
        'description': 'Hey Iam Using Bonly!',
        'loginUserId': response.user!.id,
      });

      print('Profile insert: $r');

      return response.user!.id;
    } on AuthException catch (e) {
      throw Exception('Auth error: ${e.message}');
    } catch (e) {
      print(e);
      throw Exception('Registration failed: $e');
    }
  }
}
