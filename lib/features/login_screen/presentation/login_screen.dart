import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/login_screen/presentation/bloc/login_event.dart';
import 'package:bondly/features/login_screen/presentation/bloc/login_state.dart';
import 'package:bondly/shared/global_widgets/primary_button.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:bondly/shared/global_widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/auth_screen_widgets/auth_banner.dart';
import '../../profile_screen/presentation/bloc/profile_bloc.dart';
import '../../profile_screen/presentation/bloc/profile_event.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Routing.replace(location: AppRouteConstants.homeRoute, context: context);
          final bloc = context.read<LoginBloc>();
          bloc.emit(LoginInitial(state.isPasswordVisible, email: state.email, password: state.password));
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
        builder: (context, state){
          final bloc = context.read<LoginBloc>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: currentWidth,
              padding: EdgeInsets.only(left: 16,right: 16,top:65,bottom: 20),
              decoration: BoxDecoration(
                  color: AppTheme.white
              ),
              child: Column(
                children: [
                  AuthBanner(),
                  CText(
                    padding: EdgeInsets.only(top: 40,bottom: 10),
                    text: "Let’s get you sign in",
                    fontSize: isMobile?AppTheme.big:AppTheme.ultraBig,
                    fontWeight: FontWeight.w700,
                  ),
                  CText(
                    padding: EdgeInsets.only(left: 16,right: 16,bottom: 25),
                    text: "Post freely, read securely — all within your private circle",
                    fontSize: isMobile?AppTheme.large:AppTheme.big,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    textColor: AppTheme.black.withValues(alpha: 0.5),
                  ),
                  Container(
                    padding: isMobile?EdgeInsets.zero:EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    margin: isMobile?EdgeInsets.zero:EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    child: Column(
                      spacing: 20,
                      children: [
                        CTextField(
                          controller: emailCtl,
                          label: "Email",
                          errorText: state.email,
                          prefixIcon: Icon(CupertinoIcons.mail,color: AppTheme.black.withValues(alpha: 0.2),),
                          onChange: (v){
                            if (state is LoginFailure) {
                              bloc.emit(LoginInitial(state.isPasswordVisible, email: state.email, password: state.password));
                            }else{
                              bloc.add(EmailChangedLogin(v));
                            }
                          },
                        ),
                        CTextField(
                          controller: passwordCtl,
                          label: "Password",
                          obscureText: !state.isPasswordVisible,
                          errorText: state.password,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              if (state is LoginFailure) {
                                bloc.emit(LoginInitial(state.isPasswordVisible, email: state.email, password: state.password));
                              }else{
                                bloc.add(TogglePassword());
                              }
                            },
                              child: Icon(state.isPasswordVisible?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: AppTheme.black.withValues(alpha: 0.2),size: 18,)),
                          prefixIcon: Icon(CupertinoIcons.lock_circle,color: AppTheme.black.withValues(alpha: 0.2),),
                          onChange: (v){
                            if (state is LoginFailure) {
                              bloc.emit(LoginInitial(state.isPasswordVisible, email: state.email, password: state.password));
                            }else{
                              bloc.add(PasswordChangedLogin(v));
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        PrimaryButton(
                          isLoading: state is LoginLoading?true:false,
                          value: "Login",
                          isDisable: (state.email!=null || state.password!=null || passwordCtl.text.isEmpty || emailCtl.text.isEmpty),
                          onTab: (){
                            if (state.email==null && state.password==null) {
                              bloc.add(
                                LoginSubmitted(
                                  email: emailCtl.text,
                                  password: passwordCtl.text,
                                ),
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CText(
                              text: "Haven’t registered yet? ",
                              fontSize: isMobile?AppTheme.medium:AppTheme.big,
                              fontWeight: FontWeight.w400,
                              textColor: AppTheme.black,
                            ),
                            GestureDetector(
                              onTap: (){
                                Routing.push(location: AppRouteConstants.registerRoute, context: context);
                              },
                              child: CText(
                                text: "Register",
                                fontSize: isMobile?AppTheme.medium:AppTheme.big,
                                fontWeight: FontWeight.w500,
                                textColor: AppTheme.secondaryColor,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        );
  }
}
