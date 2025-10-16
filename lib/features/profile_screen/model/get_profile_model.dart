class ProfileModel {
  final String name;
  final String profilePic;
  final String email;
  final String loginUserId;
  final String description;
  final int readCount;
  final int likeCount;
  final int followerCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileModel({
    required this.name,
    required this.profilePic,
    required this.description,
    required this.readCount,
    required this.likeCount,
    required this.followerCount,
    required this.email,
    required this.loginUserId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
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