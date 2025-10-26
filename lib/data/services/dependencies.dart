import 'package:bondly/data/services/environment.dart';
import 'package:bondly/data/services/store_user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:bondly/features/injection_container.dart' as di;
import 'package:supabase_flutter/supabase_flutter.dart';

class AppInjector{
  static Future<void> injection()async{
    WidgetsFlutterBinding.ensureInitialized();
    await StoreUserData.init();
    // try {
    //   await Supabase.initialize(
    //     url: Environment.supabaseUrl,
    //     anonKey: Environment.supabaseAnonKey,
    //   );
    // } catch (e) {
    //   print('Supabase initialization failed: $e');
    // }
    di.coreInit();
    di.loginInit();
    di.registerInit();
    di.profileInit();
    di.editProfileInit();
  }
}