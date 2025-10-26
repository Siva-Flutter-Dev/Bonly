import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:bondly/shared/global_widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';
import '../../../core/utils/assets_constants.dart';
import '../../../data/services/store_user_data.dart';
import '../../../shared/global_widgets/text.dart';
import '../../../shared/global_widgets/text_field.dart';
import 'bloc/edit_profile_event.dart';

class EditProfileScreen extends StatelessWidget {
  final Map<String,dynamic> extras;
  const EditProfileScreen({super.key, required this.extras});

  @override
  Widget build(BuildContext context) {
    final nameCtl = TextEditingController(text: extras['name']);
    final descriptionCtl = TextEditingController(text: extras['description']);
    var storeUserData = StoreUserData();
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    return Scaffold(
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state){},
        builder: (context, state){
          final bloc = context.read<EditProfileBloc>();
          if(state is EditProfileLoading){
            return CircularProgressIndicator();
          }else{
            return Padding(
              padding: const EdgeInsets.only(right: 16,left: 16,top: 60),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        text:"Edit Profile",
                        fontSize: isMobile?AppTheme.medium:AppTheme.big,
                        fontWeight: FontWeight.w500,
                      ),
                      if(!state.isEditProfileClicked)
                      GestureDetector(
                          onTap: (){
                            bloc.add(EditableClick());
                          },
                          child: Image.asset(AssetsPath.editIcon,height: 24,width: 24,)
                      ),
                    ],
                  ),
                  CachedNetworkImage(
                    imageUrl: extras['profilePic'],
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 46,
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
                  SizedBox(height: 10,),
                  CTextField(
                    controller: nameCtl,
                    label: "Name",
                    readOnly:!state.isEditProfileClicked,
                    //errorText: state.email,
                    prefixIcon: Icon(CupertinoIcons.person,color: AppTheme.black.withValues(alpha: 0.2),),
                    onChange: (v){

                    },
                  ),
                  CTextField(
                    controller: descriptionCtl,
                    label: "Description",
                    readOnly: !state.isEditProfileClicked,
                    //errorText: state.email,
                    prefixIcon: Icon(CupertinoIcons.news,color: AppTheme.black.withValues(alpha: 0.2),),
                    onChange: (v){

                    },
                  ),
                  SizedBox(height: 40,),
                  PrimaryButton(
                    value: "Save",
                    onTab: (){
                      Routing.replace(
                          location: AppRouteConstants.homeRoute,
                          context: context,
                        values: {
                          'name':nameCtl.text,
                          'description':descriptionCtl.text,
                        }
                      );
                    }
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
