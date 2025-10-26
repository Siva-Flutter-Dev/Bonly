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

      print("==================");
      print(response);

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

      print('Uploaded file URL: $publicUrl');
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
          print('Old image deleted: $oldFilePath');
        } catch (_) {
          print('No old image to delete or deletion failed');
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

      print('Profile updated: $response');
    } on StorageException catch (e) {
      throw Exception(e.message ?? 'Failed to upload image');
    } on PostgrestException catch (e) {
      throw Exception(e.message ?? 'Failed to update profile in database');
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
      print("✅ User logged out successfully");
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected logout error: $e');
    }
  }
}

// class ProfileApiService {
//   final NetworkInfo networkInfo;
//
//   ProfileApiService({required this.networkInfo});
//
//   /// Base headers for Supabase REST API
//   Map<String, String> get _headers => {
//     'apikey': Environment.supabaseAnonKey,
//     'Authorization': 'Bearer ${Environment.supabaseAnonKey}',
//     'Content-Type': 'application/json',
//   };
//
//   /// Fetch user profile by email
//   Future<ProfileModel> fetchUserProfile() async {
//     final connected = await networkInfo.isConnected;
//     if (!connected) throw Exception('No Internet connection');
//
//     final storeUserData = StoreUserData();
//     final email = storeUserData.getString(AppConstants.userEmail);
//
//     final url = Uri.parse(
//         '${Environment.supabaseUrl}/rest/v1/${Environment.profileTable}?email=eq.$email&select=*');
//
//     final response = await http.get(url, headers: _headers);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List<dynamic>;
//       if (data.isEmpty) throw Exception('Profile not found');
//       return ProfileModel.fromMap(data.first);
//     } else {
//       throw Exception('Failed to fetch profile: ${response.body}');
//     }
//   }
//
//   /// Upload image to Supabase Storage using HTTP (via Supabase signed URL)
//   Future<String> uploadProfileImage(String filePath) async {
//     final connected = await networkInfo.isConnected;
//     if (!connected) throw Exception('No Internet connection');
//
//     final fileName =
//         '${DateTime.now().millisecondsSinceEpoch}_${filePath.split('/').last}';
//     final bucketPath = '${Environment.supabaseProfileFolder}/$fileName';
//
//     final fileBytes = await File(filePath).readAsBytes();
//
//     final url = Uri.parse(
//         '${Environment.supabaseUrl}/storage/v1/object/${Environment.projectName}/$bucketPath');
//
//     final response = await http.put(
//       url,
//       headers: {
//         'Authorization': 'Bearer ${Environment.supabaseAnonKey}',
//         'Content-Type': 'application/octet-stream',
//       },
//       body: fileBytes,
//     );
//
//     if (response.statusCode != 200 && response.statusCode != 201) {
//       throw Exception('Failed to upload image: ${response.body}');
//     }
//
//     // Return public URL
//     return '${Environment.supabaseUrl}/storage/v1/object/public/${Environment.projectName}/$bucketPath';
//   }
//
//   /// Update user profile image URL in database
//   Future<void> updateUserProfileImage(String userId, String imageUrl) async {
//     final connected = await networkInfo.isConnected;
//     if (!connected) throw Exception('No Internet connection');
//
//     final url = Uri.parse(
//         '${Environment.supabaseUrl}/rest/v1/${Environment.profileTable}?id=eq.$userId');
//
//     final response = await http.patch(
//       url,
//       headers: _headers,
//       body: jsonEncode({'profilePic': imageUrl}),
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to update profile: ${response.body}');
//     }
//
//     print('Profile updated successfully');
//   }
//
//   /// Log out user
//   Future<void> logOutUser() async {
//     final connected = await networkInfo.isConnected;
//     if (!connected) throw Exception('No Internet connection');
//
//     final url = Uri.parse('${Environment.supabaseUrl}/auth/v1/logout');
//
//     final response = await http.post(url, headers: _headers);
//
//     if (response.statusCode != 200) {
//       throw Exception('Logout failed: ${response.body}');
//     }
//
//     final store = StoreUserData();
//     store.clearData();
//
//     print('✅ User logged out successfully');
//   }
// }

