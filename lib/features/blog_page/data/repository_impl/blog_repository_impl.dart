import 'package:bondly/features/blog_page/data/service/blog_service.dart';
import 'package:bondly/features/blog_page/domain/entities/blog_entitiy.dart';
import 'package:bondly/features/blog_page/domain/repository/blog_repository.dart';

class BlogRepositoryImpl extends BlogRepository{
  final BlogService blogService;

  BlogRepositoryImpl(this.blogService);

  @override
  Future<List<BlogEntity>> getBlogs() async{
    return await blogService.fetchBlogs();
  }

}