import 'package:bondly/features/blog_page/domain/entities/blog_entitiy.dart';
import 'package:bondly/features/blog_page/domain/repository/blog_repository.dart';

class GetBlogs {
  final BlogRepository blogRepository;
  GetBlogs(this.blogRepository);

  Future<List<BlogEntity>> call()async{
    return await blogRepository.getBlogs();
  }
}