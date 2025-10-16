import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/features/profile_screen/profile_screen.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blog_detail_screen/blog_detail_screen.dart';
import 'home_bloc/home_bloc.dart';
import 'home_bloc/home_event.dart';
import 'home_bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Widget> _pages = const [
    BlogDetailScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final currentIndex = state.index;

          return Scaffold(
            body: Container(
              width: currentWidth,
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: AppTheme.white,
              child: Stack(
                children: [
                  IndexedStack(
                    index: currentIndex,
                    children: _pages,
                  ),
                  Align(
                    alignment: AlignmentGeometry.lerp(AlignmentGeometry.bottomCenter, AlignmentGeometry.topCenter, 0.05)!,
                    child: Container(
                      height: isMobile?70:85,
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      width: isMobile?(currentWidth/1.5):(currentWidth/1.7),
                      decoration: BoxDecoration(
                        color: AppTheme.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _pages.asMap().entries.map((entry) {
                          final isSelected = entry.key == currentIndex;

                          return GestureDetector(
                            onTap: () {
                              context.read<HomeBloc>().add(ChangeTabEvent(entry.key));
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              height: isMobile?55:65,
                              width: isSelected ? (isMobile?(currentWidth / 2.5):(currentWidth / 1.5) / 1.6) + 12 : isMobile?55:65,
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryColor,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppTheme.white),
                              ),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  child: isSelected
                                      ? FittedBox(
                                    fit: BoxFit.scaleDown,
                                        child: Row(
                                         key: ValueKey('selected-${entry.key}'),
                                         mainAxisSize: MainAxisSize.min,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                        Icon(
                                          entry.key == 0
                                              ? CupertinoIcons.doc_plaintext
                                              : CupertinoIcons.person,
                                          size: isMobile?20:30,
                                          color: AppTheme.white,
                                        ),
                                        const SizedBox(width: 5),
                                        CText(
                                          text: entry.key == 0 ? "Detail" : "Profile",
                                          textColor: AppTheme.white,
                                          fontSize: isMobile?AppTheme.medium:AppTheme.big,
                                          fontWeight: FontWeight.w500,
                                        ),
                                     ],
                                     ),
                                  )
                                      : Icon(
                                    entry.key == 0
                                        ? CupertinoIcons.doc_plaintext
                                        : CupertinoIcons.person,
                                    key: ValueKey('unselected-${entry.key}'),
                                    size: isMobile?20:30,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
