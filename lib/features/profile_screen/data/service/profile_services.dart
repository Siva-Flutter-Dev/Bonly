import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:bondly/data/services/store_user_data.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/services/environment.dart';
import '../models/profile_model.dart';

class ProfileService {
  late final Client client;
  late final TablesDB tables;
  late final Storage files;
  final NetworkInfo networkInfo;

  ProfileService({required this.networkInfo}) {
    client = Client()
      ..setEndpoint(Environment.appwritePublicEndpoint)
      ..setProject(Environment.appwriteProjectId);
    tables = TablesDB(client);
    files = Storage(client);
  }

  Future<ProfileModel> fetchUserProfile() async {
    var storeUserData = StoreUserData();
    final connected = await networkInfo.isConnected;

    if (!connected) {
      throw Exception('No Internet connection');
    }
    try {
      final response = await tables.listRows(
        databaseId: Environment.appwriteDatabaseId,
        tableId: Environment.appwriteProfileTable,
        queries: [
          Query.equal('email', storeUserData.getString(AppConstants.userEmail)),
        ],
      );
      print("==================");
      print(response);

      return ProfileModel.fromMap(response.rows.first.data);
    } on AppwriteException catch (e) {
      throw Exception(e.message ?? 'Failed to load profile');
    }
  }

  /// Upload a profile image and return file ID
  Future<String> uploadProfileImage(String filePath) async {
    final connected = await networkInfo.isConnected;

    if (!connected) {
      throw Exception('No Internet connection');
    }
    try {
      final result = await files.createFile(
        bucketId: Environment.appwriteStorageBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: filePath,
          filename: filePath.split('/').last,
        ),
      );
      return result.$id;
    } on AppwriteException catch (e) {
      throw Exception(e.message ?? 'Failed to upload image');
    }
  }

  /// Generate public preview URL for the uploaded file
  Future<File?> getProfileImageUrl(String fileId) async{
    File? fileUrl;
    await files.getFile(
      bucketId: Environment.appwriteStorageBucketId,
      fileId: fileId,
    ).then((value){
      fileUrl=value as File?;
    });
    return fileUrl;
  }

  /// Update the user's profile row with new profile image
  Future<void> updateUserProfileImage(String rowId, String fileId) async {
    final connected = await networkInfo.isConnected;

    if (!connected) {
      throw Exception('No Internet connection');
    }
    try {
      final profileImageUrl = getProfileImageUrl(fileId);

      await tables.updateRow(
        databaseId: Environment.appwriteDatabaseId,
        tableId: Environment.appwriteProfileTable,
        rowId: rowId,
        data: {
          'profilePic': profileImageUrl,
        },
      );
    } on AppwriteException catch (e) {
      throw Exception(e.message ?? 'Failed to update profile image');
    }
  }

}
