import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: CText(text: "Detail"),
      ),
    );
  }
}
