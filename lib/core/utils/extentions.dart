import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'enums.dart';

extension AppScreenSize on BuildContext{
  double get mediaQueryHeight => MediaQuery.sizeOf(this).height;
  double get mediaQueryWidth => MediaQuery.sizeOf(this).width;
  bool isMobile() => mediaQueryWidth < DeviceType.ipad.getMinWidth();
  TargetPlatform get os => defaultTargetPlatform;
}

extension DeviceTypeExtension on DeviceType {
  double getMinWidth() {
    switch (this) {
      case DeviceType.mobile:
        return 0;
      case DeviceType.tablet:
        return 600;
      case DeviceType.ipad:
        return 768;
      case DeviceType.desktop:
        return 1024;
    }
  }
}