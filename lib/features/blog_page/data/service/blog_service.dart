import 'package:bondly/features/blog_page/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/services/environment.dart';

class BlogService{
  final NetworkInfo networkInfo;
  late final SupabaseClient supabase;

  BlogService({required this.networkInfo}) {
    supabase = SupabaseClient(
      Environment.supabaseUrl,
      Environment.supabaseAnonKey,
    );
  }

  Future<List<BlogDetails>> fetchBlogs() async {
    final connected = await networkInfo.isConnected;

    if (!connected) throw Exception('No Internet connection');

    try {

      final response = await supabase
          .from(Environment.blogTable)
          .select()
          .order('createdAt', ascending: false);

      return (response)
          .map((e) => BlogDetails.fromMap(e))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error loading profile: $e');
    }
  }
}