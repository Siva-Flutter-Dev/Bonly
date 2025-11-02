import 'package:bondly/features/blog_page/domain/entities/blog_entitiy.dart';

abstract class BlogState{
  final int tabActiveIndex;
  final List<BlogEntity> blogs;
  final List<BlogEntity> allBlogs;
  BlogState({required this.tabActiveIndex,required this.blogs,required this.allBlogs});
}
class BlogInitial extends BlogState{
  BlogInitial({required super.tabActiveIndex, required super.blogs, required super.allBlogs});
}
class BlogLoading extends BlogState{
  BlogLoading({required super.tabActiveIndex, required super.blogs, required super.allBlogs});
}
class BlogSuccess extends BlogState{
  BlogSuccess({required super.tabActiveIndex, required super.blogs, required super.allBlogs});
}
class BlogFailure extends BlogState{
  BlogFailure({required super.tabActiveIndex, required super.blogs, required super.allBlogs});
}