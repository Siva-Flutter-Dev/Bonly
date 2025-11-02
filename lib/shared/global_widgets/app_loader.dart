import 'dart:async';
import 'dart:math' as math;
import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/assets_constants.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Timer? _dotTimer;
  String _dots = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (_dots.length >= 3) {
          _dots = "";
        } else {
          _dots += ".";
        }
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _dotTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetsPath.loadIcon, width: 80, height: 80),
                  AnimatedBuilder(
                    animation: _controller!,
                    builder: (_, _) {
                      final angle = _controller!.value * 6.283;
                      return Transform.translate(
                        offset: Offset(50 * math.cos(angle), 50 * math.sin(angle)),
                        child: CircleAvatar(radius: 6, backgroundColor: AppTheme.extraColor),
                      );
                    },
                  ),
                ],
              ),
            ),
            CText(
              text: "Loading$_dots",
              fontSize: AppTheme.large,
              fontWeight: FontWeight.w700,
      
            )
          ],
        ),
      ),
    );
  }
}
