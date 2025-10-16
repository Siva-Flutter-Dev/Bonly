import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CText(text: "Detail"),
      ),
    );
  }
}
