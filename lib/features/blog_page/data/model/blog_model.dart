import 'package:bondly/features/blog_page/domain/entities/blog_entitiy.dart';

class BlogDetails extends BlogEntity{
  BlogDetails({
    required super.id,
    required super.createdAt,
    required super.blogTitle,
    required super.blogDescription,
    required super.blogPicture,
    required super.isTop,
    required super.isPopular,
    required super.isTrending,
    required super.isFavorite,
    required super.isRecommended,
    required super.updatedAt,
    required super.likeCounts,
    required super.savedBy,
    required super.likedBy,
    required super.userId
  });

  factory BlogDetails.fromMap(Map<String, dynamic> json) => BlogDetails(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    blogTitle: json["blogTitle"],
    blogDescription: json["blogDescription"],
    blogPicture: json["blogPicture"],
    isTop: json["isTop"],
    isPopular: json["isPopular"],
    isTrending: json["isTrending"],
    isFavorite: json["isFavorite"],
    isRecommended: json["isRecommended"],
    updatedAt: json["updatedAt"],
    likeCounts: json["likeCounts"],
    savedBy: List<int>.from(json["savedBy"].map((x) => x)),
    likedBy: List<int>.from(json["likedBy"].map((x) => x)),
    userId: json["userId"],
  );
}