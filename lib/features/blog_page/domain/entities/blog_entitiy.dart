class BlogEntity {
  int id;
  DateTime createdAt;
  String blogTitle;
  String blogDescription;
  String? blogPicture;
  bool isTop;
  bool isPopular;
  bool isTrending;
  bool isFavorite;
  bool isRecommended;
  DateTime? updatedAt;
  int likeCounts;
  List<int> savedBy;
  List<int> likedBy;
  int userId;

  BlogEntity({
    required this.id,
    required this.createdAt,
    required this.blogTitle,
    required this.blogDescription,
    required this.blogPicture,
    required this.isTop,
    required this.isPopular,
    required this.isTrending,
    required this.isFavorite,
    required this.isRecommended,
    required this.updatedAt,
    required this.likeCounts,
    required this.savedBy,
    required this.likedBy,
    required this.userId,
  });
}