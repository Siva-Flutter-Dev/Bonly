import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/blog_page/presentation/bloc/blog_bloc.dart';
import 'package:bondly/features/blog_page/presentation/bloc/blog_event.dart';
import 'package:bondly/features/blog_page/presentation/bloc/blog_state.dart';
import 'package:bondly/features/blog_page/presentation/screen/widgets/list_card.dart';
import 'package:bondly/shared/global_widgets/carousel_slider.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/global_widgets/app_loader.dart';
import '../../../../shared/global_widgets/no_data_found.dart';

class BlogScreen extends StatelessWidget {
  final Map<String,dynamic>? extra;
  BlogScreen({super.key, this.extra});

  // final List<int> items = [1,2,3,4,5,6,7];
  final List<String> tabs = ['Top','Popular','Trending','Favorites'];
  static bool _hasFetchedProfile = false;

  @override
  Widget build(BuildContext context) {
    var currentWidth = context.mediaQueryWidth;
    bool isMobile = context.isMobile();
    if (!_hasFetchedProfile) {
      _hasFetchedProfile = true;
      context.read<BlogBloc>().add(BlogFetched());
    }
    return BlocConsumer<BlogBloc,BlogState>(
      listener: (context,state) {
        // if(state is BlogSuccess){
        //   print(state.blogs.length);
        // }
      },
      builder: (context,state) {
        if(state is BlogLoading || state is BlogInitial){
          return AppLoader();
        }else if(state is BlogFailure){
          return Container();
        }else{
          return DefaultTabController(
            length: tabs.length,
            initialIndex: context.read<BlogBloc>().state.tabActiveIndex,
            child: Scaffold(
              backgroundColor: AppTheme.white,
              body: Padding(
                padding: const EdgeInsets.only(top: 60,left: 16,right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      padding: EdgeInsets.only(bottom: 12),
                      text: "Hello! ${extra?['name']??"User"}",
                      fontWeight: FontWeight.w400,
                      fontSize: AppTheme.medium,
                      textColor: AppTheme.primaryColor,
                    ),
                    CText(
                      padding: EdgeInsets.only(bottom: 12),
                      text: "Recommended",
                      fontWeight: FontWeight.w700,
                      fontSize: AppTheme.big,
                    ),
                    SizedBox(
                      height: isMobile?currentWidth*0.6:currentWidth/1.5,
                      child: CarouselSliderWidget(
                          infiniteScroll: true,
                          items: state.allBlogs.map((i){
                            return Container(
                              width: currentWidth/2.2,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(i.blogPicture??"")
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CText(
                                    text: i.blogTitle,
                                    fontSize: AppTheme.large,
                                    overflow: TextOverflow.visible,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppTheme.white,
                                  ),
                                  if(i.isTrending)
                                    Row(
                                      spacing: 5,
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: AppTheme.selectiveColor,
                                        ),
                                        CText(
                                          text: 'Trending',
                                          fontSize: AppTheme.medium,
                                          overflow: TextOverflow.visible,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppTheme.white,
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            );
                          }).toList(),
                          enLargeCenter: false,
                          height: isMobile?currentWidth*0.6:currentWidth/1.5,
                          viewportFraction: 1/2
                      ),
                    ),
                    SizedBox(height: 18,),
                    Builder(
                      builder: (context) {
                        final tabController = DefaultTabController.of(context);
                        tabController.addListener(() {
                          if (!tabController.indexIsChanging) {
                            context.read<BlogBloc>().add(TabBarEvent(index:tabController.index));
                          }
                        });
                        return TabBar(
                          tabAlignment: TabAlignment.center,
                          controller: tabController,
                          isScrollable: true,
                          dividerColor: AppTheme.transparent,
                          indicatorColor: AppTheme.transparent,
                          labelColor: AppTheme.primaryColor,
                          unselectedLabelColor: AppTheme.grey,
                          tabs: tabs.asMap().entries.map((entry) {
                            final index = entry.key;
                            final title = entry.value;
                            return Tab(
                              child: CText(
                                text: title,
                                fontWeight: state.tabActiveIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: state.tabActiveIndex == index
                                    ?AppTheme.large:AppTheme.medium,
                                textColor: state.tabActiveIndex == index
                                    ?AppTheme.primaryColor:AppTheme.grey,
                              ),
                            );
                          }).toList(),
                        );

                      },
                    ),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: state.blogs.isNotEmpty
                        ?ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.blogs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BlogListCard(blogDetail: state.blogs[index]);
                          },
                        ):NoDataFoundWidget(),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
