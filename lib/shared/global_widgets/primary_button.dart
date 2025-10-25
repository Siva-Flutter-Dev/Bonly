import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  final String value;
  final VoidCallback onTab;
  final bool isLoading;
  final bool isDisable;
  const PrimaryButton({super.key, required this.value, required this.onTab, this.isLoading=false,this.isDisable=false});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile();
    var currentWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: !isDisable?onTab:null,
      child: Container(
        height: isMobile?48:58,
        width: currentWidth,
        decoration: BoxDecoration(
          color: isDisable?AppTheme.grey:AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: isLoading
          ?CupertinoActivityIndicator(radius: 8,color: AppTheme.white,)
          :CText(
            text: value,
            textColor: AppTheme.white,
            fontSize: isMobile?AppTheme.medium:AppTheme.big,
          ),
        ),
      ),
    );
  }
}
