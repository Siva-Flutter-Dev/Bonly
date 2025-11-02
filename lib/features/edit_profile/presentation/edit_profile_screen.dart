import 'dart:io';
import 'dart:ui' as ui;

import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bondly/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:bondly/shared/global_widgets/app_loader.dart';
import 'package:bondly/shared/global_widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/themes/app_theme.dart';
import '../../../core/utils/assets_constants.dart';
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
    final isMobile = context.isMobile();
    // var currentWidth = context.mediaQueryWidth;
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state){},
      builder: (context, state){
        final bloc = context.read<EditProfileBloc>();
        if(state is EditProfileLoading){
          return AppLoader();
        }else{
          return Scaffold(
            backgroundColor: AppTheme.white,
            body: Padding(
              padding: const EdgeInsets.only(right: 16,left: 16,top: 60),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Routing.back(context: context);
                            },
                              child: Icon(CupertinoIcons.back)),
                          CText(
                            text:"Edit Profile",
                            fontSize: isMobile?AppTheme.medium:AppTheme.big,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
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
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          final ImagePicker picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 4);

                          if (pickedFile != null) {
                            final file = File(pickedFile.path);
                            final bytes = await file.readAsBytes();
                            final codec = await ui.instantiateImageCodec(bytes, targetWidth: 40, targetHeight: 40);
                            final frame = await codec.getNextFrame();
                            final image = frame.image;
                            final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                            final resizedBytes = byteData!.buffer.asUint8List();
                            final resizedFile = File(file.path)..writeAsBytesSync(resizedBytes);
                            bloc.add(EditProfileImagePicked(resizedFile));
                          }
                        },
                        child: state.selectedImageFile!=null
                            ?Container(
                          height: 100,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(state.selectedImageFile??File(""),fit: BoxFit.cover,),
                          ),
                        )
                            :CachedNetworkImage(
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
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppTheme.secondaryColor)
                          ),
                          child: Icon(CupertinoIcons.camera,size: 18,),
                        ),
                      )
                    ],
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
                        bloc.add(EditProfileSubmitted(
                            userId: extras['id'],
                            name: nameCtl.text,
                            description: descriptionCtl.text,
                            profilePic: state.selectedImageFile
                        ));
                        Routing.back(
                            context: context,
                            values: {
                              'name':nameCtl.text,
                              'description':descriptionCtl.text,
                            }
                        );
                        bloc.add(EditableClick());
                      }
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
