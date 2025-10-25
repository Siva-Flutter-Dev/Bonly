import 'package:bondly/data/services/store_user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:bondly/features/injection_container.dart' as di;

class AppInjector{
  static Future<void> injection()async{
    WidgetsFlutterBinding.ensureInitialized();
    await StoreUserData.init();
    di.coreInit();
    di.loginInit();
    di.registerInit();
    di.profileInit();
  }
}