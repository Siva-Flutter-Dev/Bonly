import 'package:bondly/core/validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/extentions.dart';
import '../../../../shared/auth_screen_widgets/auth_banner.dart';
import '../../../../shared/global_widgets/primary_button.dart';
import '../../../../shared/global_widgets/text.dart';
import '../../../../shared/global_widgets/text_field.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final confirmPasswordCtl = TextEditingController();
  final nameCtl = TextEditingController();

  void _onRegisterPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          name: nameCtl.text,
          email: emailCtl.text,
          password: passwordCtl.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = context.mediaQueryWidth;
    final isMobile = context.isMobile();

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Routing.replace(location: AppRouteConstants.loginRoute, context: context);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: currentWidth,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 65, bottom: 20),
            decoration: const BoxDecoration(color: AppTheme.white),
            child: Column(
              children: [
                const AuthBanner(),
                CText(
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  text: "Start your journey with us",
                  fontSize: isMobile ? AppTheme.big : AppTheme.ultraBig,
                  fontWeight: FontWeight.w700,
                ),
                CText(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
                  text: "Post freely, read securely — all within your private circle",
                  fontSize: isMobile ? AppTheme.large : AppTheme.big,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  textColor: AppTheme.black.withValues(alpha: 0.5),
                ),
                Container(
                  padding: isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  margin: isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 20,
                      children: [
                        CTextField(
                          controller: nameCtl,
                          label: "Name",
                          validator: (val) => val == null || val.isEmpty ? 'Enter name' : null,
                          prefixIcon: Icon(CupertinoIcons.person, color: AppTheme.black.withValues(alpha: 0.2)),
                        ),
                        CTextField(
                          controller: emailCtl,
                          label: "Email",
                          validator: (val) => val == null || !AppValidators.isEmailValid(val) ? 'Enter valid email' : null,
                          prefixIcon: Icon(CupertinoIcons.mail, color: AppTheme.black.withValues(alpha: 0.2)),
                        ),
                        CTextField(
                          controller: passwordCtl,
                          label: "Password",
                          obscureText: !state.isPasswordVisible,
                          validator: (val) => val == null || val.length < 6 ? 'Min 6 characters' : null,
                          suffixIcon: GestureDetector(
                              onTap: (){
                                context.read<RegisterBloc>().add(TogglePasswordRegister());
                              },
                              child: Icon(state.isPasswordVisible?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: AppTheme.black.withValues(alpha: 0.2),size: 18,)),
                          prefixIcon: Icon(CupertinoIcons.lock_circle, color: AppTheme.black.withValues(alpha: 0.2)),
                        ),
                        CTextField(
                          controller: confirmPasswordCtl,
                          label: "Confirm Password",
                          obscureText: true,
                          validator: (val) => val == null || val != passwordCtl.text ? 'Not match' : null,
                          prefixIcon: Icon(CupertinoIcons.lock_circle, color: AppTheme.black.withValues(alpha: 0.2)),
                        ),
                        const SizedBox(height: 10),
                        PrimaryButton(
                          isLoading: state is RegisterLoading,
                          value: "Register",
                          onTab: ()=>_onRegisterPressed(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
