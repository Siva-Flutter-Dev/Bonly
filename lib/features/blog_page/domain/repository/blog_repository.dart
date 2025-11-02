import 'package:bondly/features/blog_page/domain/entities/blog_entitiy.dart';

abstract class BlogRepository{
  Future<List<BlogEntity>> getBlogs();
}