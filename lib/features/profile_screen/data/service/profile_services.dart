import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bondly/data/services/store_user_data.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/services/environment.dart';
import '../models/profile_model.dart';

class ProfileService {
  final NetworkInfo networkInfo;
  late final SupabaseClient supabase;

  ProfileService({required this.networkInfo}) {
    supabase = SupabaseClient(
      Environment.supabaseUrl,
      Environment.supabaseAnonKey,
    );
  }

  /// Fetch user profile from "profiles" table
  Future<ProfileModel> fetchUserProfile() async {
    final storeUserData = StoreUserData();
    final connected = await networkInfo.isConnected;

    if (!connected) throw Exception('No Internet connection');

    try {
      final email = storeUserData.getString(AppConstants.userEmail);

      final response = await supabase
          .from(Environment.profileTable)
          .select()
          .eq('email', email)
          .limit(1)
          .maybeSingle();

      if (response == null) throw Exception('Profile not found');


      return ProfileModel.fromMap(response);
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error loading profile: $e');
    }
  }

  /// Upload a profile image to Supabase Storage and return the public URL
  Future<String> uploadProfileImage(String filePath) async {
    final connected = await networkInfo.isConnected;
    if (!connected) throw Exception('No Internet connection');

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${filePath.split('/').last}';
      final fileBytes = await File(filePath).readAsBytes();

      final filePathInBucket = '${Environment.supabaseProfileFolder}/$fileName';

      final response = await supabase.storage
          .from(Environment.projectName)
          .uploadBinary(filePathInBucket, fileBytes,
          fileOptions: const FileOptions(upsert: true));

      if (response.isEmpty) throw Exception('Upload failed');

      // Generate a public URL
      final publicUrl = supabase.storage
          .from(Environment.projectName)
          .getPublicUrl(filePathInBucket);

      return publicUrl;
    } on StorageException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected upload error: $e');
    }
  }

  /// Update the user's profile picture in the "profiles" table
  Future<void> updateUserProfileImage(String userId, String filePath, {String? oldFilePath}) async {
    final connected = await networkInfo.isConnected;
    if (!connected) throw Exception('No Internet connection');

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${filePath.split('/').last}';
      final newFilePathInBucket = '${Environment.supabaseProfileFolder}/$fileName';
      final fileBytes = await File(filePath).readAsBytes();

      // Optional: Delete the old image if exists
      if (oldFilePath != null && oldFilePath.isNotEmpty) {
        try {
          await supabase.storage.from(Environment.projectName).remove([oldFilePath]);
        } catch (_) {

        }
      }

      // Upload new image
      await supabase.storage
          .from(Environment.projectName)
          .uploadBinary(
        newFilePathInBucket,
        fileBytes,
        fileOptions: const FileOptions(upsert: true),
      );

      // Get public URL
      final imageUrl = supabase.storage.from(Environment.projectName).getPublicUrl(newFilePathInBucket);

      // Update profile table
      final response = await supabase
          .from(Environment.profileTable)
          .update({'profilePic': imageUrl})
          .eq('id', userId);

    } on StorageException catch (e) {
      throw Exception(e.message);
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  /// Log out the current user
  Future<void> logOutUser() async {
    final connected = await networkInfo.isConnected;
    if (!connected) throw Exception('No Internet connection');

    try {
      await supabase.auth.signOut();
      final store = StoreUserData();
      store.clearData();
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected logout error: $e');
    }
  }
}

