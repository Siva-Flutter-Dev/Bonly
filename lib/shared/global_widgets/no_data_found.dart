import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/cupertino.dart';

class NoDataFoundWidget extends StatefulWidget {
  final String message;
  final String? imagePath;
  final double imageSize;
  final Color textColor;

  const NoDataFoundWidget({
    super.key,
    this.message = "No Data Found",
    this.imagePath,
    this.imageSize = 60,
    this.textColor = AppTheme.extraColor,
  });

  @override
  State<NoDataFoundWidget> createState() => _NoDataFoundWidgetState();
}

class _NoDataFoundWidgetState extends State<NoDataFoundWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _fadeAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnim = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.doc_text_search,
                color: AppTheme.grey.withValues(alpha: 0.6),
                size: widget.imageSize,
              ),
              const SizedBox(height: 20),
              CText(
                text:widget.message,
                fontSize: AppTheme.medium,
                textColor: widget.textColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
