import 'package:bondly/features/blog_page/domain/usecases/blog_usecase.dart';
import 'package:bondly/features/blog_page/presentation/bloc/blog_event.dart';
import 'package:bondly/features/blog_page/presentation/bloc/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent,BlogState>{
  final GetBlogs getBlogs;
  BlogBloc({required this.getBlogs}):super(BlogInitial(tabActiveIndex: 0, blogs: [], allBlogs: [])){
    on<BlogFetched>(_fetchBlog);
    on<TabBarEvent>(_tabBarEvent);
  }

  void _fetchBlog(BlogFetched event,emit)async{
    emit(BlogLoading(tabActiveIndex: state.tabActiveIndex, blogs: state.blogs, allBlogs: state.allBlogs));
    try {
      final blogs = await getBlogs();
      emit(BlogSuccess(tabActiveIndex: state.tabActiveIndex, blogs: blogs, allBlogs: blogs));
    } catch (e) {
      emit(BlogFailure(tabActiveIndex: state.tabActiveIndex, blogs: state.blogs, allBlogs: state.allBlogs));
    }
  }

  void _tabBarEvent(TabBarEvent event,emit){
    final allBlogs = state.allBlogs;
    final sortedBlogs = allBlogs.where((b){
      if(event.index==0){
        return b.isTop;
      }else if(event.index==1){
        return b.isPopular;
      }else if(event.index==2){
        return b.isTrending;
      }else{
        return b.isFavorite;
      }
    }).toList();
    emit(BlogSuccess(tabActiveIndex: event.index, blogs: sortedBlogs, allBlogs: state.allBlogs));
  }

}