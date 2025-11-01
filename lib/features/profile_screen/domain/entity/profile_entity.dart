class Profile {
  final int id;
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

  Profile({
    required this.id,
    required this.name,
    required this.profilePic,
    required this.email,
    required this.loginUserId,
    required this.description,
    required this.readCount,
    required this.likeCount,
    required this.followerCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
