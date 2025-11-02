import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/utils.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/blog_entitiy.dart';

class BlogListCard extends StatelessWidget {
  final BlogEntity blogDetail;
  const BlogListCard({super.key, required this.blogDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14)
      ),
      child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              height: 65,
              width: 65,
              fit: BoxFit.cover,
                blogDetail.blogPicture??""
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: blogDetail.blogTitle,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.visible,
                  fontSize: AppTheme.medium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        Icon(CupertinoIcons.timer,color: AppTheme.primaryColor,size: 18,),
                        CText(
                          text: Utils.timeAgo(blogDetail.createdAt),
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                          fontSize: AppTheme.tiny,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CText(
                          text: " ${blogDetail.likeCounts} ${blogDetail.likeCounts>1?'likes':'like'}",
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                          fontSize: AppTheme.medium,
                        ),
                        Icon(CupertinoIcons.heart_circle_fill,size: 18,color: AppTheme.red,),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
