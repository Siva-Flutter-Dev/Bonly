import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/assets_constants.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:bondly/features/profile_screen/profile_bloc/profile_event.dart';
import 'package:bondly/features/profile_screen/profile_bloc/profile_state.dart';
import 'package:bondly/features/profile_screen/service/profile_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/paint/zebra_paint.dart';
import '../../data/services/store_user_data.dart';
import '../../shared/global_widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var storeUserData = StoreUserData();
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    return BlocProvider(
      create: (_) => ProfileBloc(profileService: ProfileService())..add(LoadUserProfile()),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return Padding(
                padding: const EdgeInsets.only(right: 16,left: 16,top: 60),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                                text:profile.name,
                              fontSize: isMobile?AppTheme.medium:AppTheme.big,
                              fontWeight: FontWeight.w500,
                            ),
                            Row(
                              spacing: 20,
                              children: [
                                Image.asset(AssetsPath.editIcon,height: 24,width: 24,),
                                Image.asset(AssetsPath.settingsIcon,height: 24,width: 24,),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Stack(
                          children: [
                            Container(
                              height: isMobile?120:180,
                              width: currentWidth,
                              decoration: BoxDecoration(
                                gradient: AppTheme.zebraGradient,
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: CustomPaint(
                                  painter: ZebraPainter(),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20,bottom: 40,left: 130),
                                    child: Image.asset(
                                        AssetsPath.loginBannerIcon),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: isMobile?24:36,
                              left: 20,
                              child: CachedNetworkImage(
                                imageUrl: profile.profilePic,
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  backgroundColor: AppTheme.white,
                                  radius: 35,
                                  child: CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: 30,
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircleAvatar(
                                        backgroundColor: AppTheme.white,
                                        radius: 35,
                                        child: const CupertinoActivityIndicator(radius: 8,color: AppTheme.black,)),
                                errorWidget: (context, url, error) => CircleAvatar(
                                  backgroundColor: AppTheme.white,
                                  radius: 35,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(AssetsPath.sampleProfile),
                                    radius: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CText(
                          text:profile.name,
                          fontSize: isMobile?AppTheme.big:AppTheme.ultraBig,
                          fontWeight: FontWeight.w600,
                        ),
                        CText(
                          text:profile.description,
                          fontSize: isMobile?AppTheme.small:AppTheme.large,
                          fontWeight: FontWeight.w400,
                          textColor: AppTheme.black.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                          decoration: BoxDecoration(
                            color: AppTheme.black.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _statCard("Reads ", profile.readCount),
                              _statCard("Likes ", profile.likeCount),
                              _statCard("Friends", profile.followerCount),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              print(state.message);
              return Center(child: CText(text:"Error: ${state.message}"));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _statCard(String title, int count) {
    return Column(
      children: [
        CText(
          text:'$count',
          fontSize: AppTheme.large,
          fontWeight: FontWeight.w600,
        ),
        CText(
          text:title,
          fontSize: AppTheme.small,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

