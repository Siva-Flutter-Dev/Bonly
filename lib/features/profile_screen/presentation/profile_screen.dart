import 'package:bondly/core/constants/app_constants.dart';
import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/core/utils/assets_constants.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/profile_screen/presentation/bloc/profile_bloc.dart';
import 'package:bondly/features/profile_screen/presentation/bloc/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/paint/zebra_paint.dart';
import '../../../data/services/store_user_data.dart';
import '../../../shared/global_widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/profile_event.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String,dynamic> extra;
  const ProfileScreen({super.key, required this.extra});

  static bool _hasFetchedProfile = false;

  @override
  Widget build(BuildContext context) {
    var storeUserData = StoreUserData();
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    if (!_hasFetchedProfile) {
      _hasFetchedProfile = true;
      context.read<ProfileBloc>().add(ProfileFetched());
    }
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is LogOutState) {
            storeUserData.setBoolean(AppConstants.loginSession, false);
            Routing.replace(location: AppRouteConstants.loginRoute, context: context);
            ProfileScreen._hasFetchedProfile = false;
          }
        },
        builder: (context, state) {
          final bloc = context.read<ProfileBloc>();
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }else if (state is ProfileLoaded) {
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
                              text:extra['name']??profile.name,
                            fontSize: isMobile?AppTheme.medium:AppTheme.big,
                            fontWeight: FontWeight.w500,
                          ),
                          Row(
                            spacing: 20,
                            children: [
                              GestureDetector(
                                onTap: ()async{
                                  final value = await Routing.push(
                                    location: AppRouteConstants.editProfileRoute,
                                    context: context,
                                    values: {
                                      'id':extra['id']??profile.id,
                                      'name':extra['name']??profile.name,
                                      'description':extra['description']??profile.description,
                                      'profilePic':profile.profilePic,
                                    }
                                  );
                                  if (value != null) {
                                    bloc.add(ProfileFetched());
                                  }
                                },
                                  child: Image.asset(AssetsPath.editIcon,height: 24,width: 24,)
                              ),
                              GestureDetector(
                                  onTap: (){},
                                  child: Image.asset(AssetsPath.settingsIcon,height: 24,width: 24,)),
                              GestureDetector(
                                  onTap: (){
                                    context.read<ProfileBloc>().add(LogOutEvent());
                                  },
                                  child: Icon(CupertinoIcons.power,color: Colors.red,fontWeight: FontWeight.bold,)),
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
                        text:extra['name']??profile.name,
                        fontSize: isMobile?AppTheme.big:AppTheme.ultraBig,
                        fontWeight: FontWeight.w600,
                      ),
                      CText(
                        text:extra['description']??profile.description,
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
            return Center(child: CText(text:"Error: ${state.message}"));
          } else {
            return const SizedBox();
          }
        },
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

