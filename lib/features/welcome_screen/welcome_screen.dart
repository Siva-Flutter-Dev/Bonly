import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/material.dart';
import '../../core/utils/assets_constants.dart';
import '../../shared/global_widgets/carousel_slider.dart';
import '../../shared/global_widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final List<String> images = [AssetsPath.welcomeIcon1,AssetsPath.welcomeIcon2];

  @override
  Widget build(BuildContext context) {
    // var storeUserData = StoreUserData();
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Container(
        width: currentWidth,
        padding: EdgeInsets.only(left: 16,right: 16,top: 150,bottom: 20),
        decoration: BoxDecoration(
          color: AppTheme.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSliderWidget(
              items: images.map((e){
                return Image.asset(
                    height: isMobile?currentWidth:currentWidth,
                    width: isMobile?currentWidth:currentWidth,
                    e);
              }).toList(),
              height: currentWidth,
            ),
            Column(
              spacing: 30,
              children: [
                CText(
                  text: "Your Voice, Your Community",
                  fontSize: isMobile?AppTheme.large:AppTheme.ultraBig,
                  fontWeight: FontWeight.w700,
                ),
                CText(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  text: "Build your tribe. Share meaningful content. Modify and update your posts anytime. Your content stays within your circle.",
                  fontSize: isMobile?AppTheme.medium:AppTheme.big,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
            PrimaryButton(
              value: "Let's Start",
              onTab: (){
                //storeUserData.setBoolean(AppConstants.onBoardSlide, true);
                Routing.push(location: AppRouteConstants.loginRoute, context: context);
              },
            )
          ],
        ),
      ),
    );
  }
}
