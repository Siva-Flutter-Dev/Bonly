import '../../domain/entity/profile_entity.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.email,
    required super.name,
    required super.profilePic,
    required super.loginUserId,
    required super.description,
    required super.readCount,
    required super.likeCount,
    required super.followerCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      email: map['email'] ?? '',
      loginUserId: map['loginUserId'] ?? '',
      description: map['description'] ?? '',
      readCount: map['readArticles'] ?? 0,
      likeCount: map['likeCount'] ?? 0,
      followerCount: map['followCount'] ?? 0,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
