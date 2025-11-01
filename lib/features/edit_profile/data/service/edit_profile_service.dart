import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/network/network_info.dart';
import '../../../../data/services/environment.dart';
import '../model/edit_profile_info_model.dart';

class EditProfileService{

  final NetworkInfo networkInfo;
  late final SupabaseClient supabase;

  EditProfileService({required this.networkInfo}) {
    supabase = SupabaseClient(
      Environment.supabaseUrl,
      Environment.supabaseAnonKey,
    );
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
  Future<EditProfileInfoModel> updateUserInfo({required int userId, required File? filePath, required String name, required String description, String? oldFilePath}) async {
    final connected = await networkInfo.isConnected;
    if (!connected) throw Exception('No Internet connection');

    try {
      final fileName = filePath!=null?'${DateTime.now().millisecondsSinceEpoch}_${filePath.path.split('/').last}':null;
      final newFilePathInBucket = filePath!=null?'${Environment.supabaseProfileFolder}/$fileName':null;
      final fileBytes = await filePath?.readAsBytes();

      // Upload new image
      if(filePath!=null){
        await supabase.storage
            .from(Environment.projectName)
            .uploadBinary(
          newFilePathInBucket!,
          fileBytes!,
            fileOptions: const FileOptions(upsert: true)
        );
      }

      // Get public URL
      final imageUrl = filePath!=null?supabase.storage.from(Environment.projectName).getPublicUrl(newFilePathInBucket!):null;

      // Update profile table
      final response = await supabase
          .from(Environment.profileTable)
          .update({
            'profilePic': imageUrl,
            'name':name,
            'description': description,
            'updated_at':DateTime.now().toIso8601String(),
          })
          .eq('id', userId);

      return EditProfileInfoModel(
          name: name,
          description: description,
          profilePic: filePath,
          id: userId
      );

    } on StorageException catch (e) {
      throw Exception(e.message);
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}