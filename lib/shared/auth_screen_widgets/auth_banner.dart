import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:flutter/material.dart';

import '../../core/themes/app_theme.dart';
import '../../core/utils/assets_constants.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({super.key});

  @override
  Widget build(BuildContext context) {
    //var currentWidth = context.mediaQueryWidth;
    final isMobile = context.isMobile();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Routing.back(context: context);
          },
          child: Container(
            height: isMobile?45:55,
            width: isMobile?45:55,
            decoration: BoxDecoration(
                color: AppTheme.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child:Icon(Icons.arrow_back,size: isMobile?20:30,color: AppTheme.black,),
            ),
          ),
        ),
        Image.asset(AssetsPath.loginBannerIcon,height: isMobile?60:80,)
      ],
    );
  }
}
