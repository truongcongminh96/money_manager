import 'package:money_manager/common/enum/screen_size.dart';

ScreenSize calculateScreenSize(double width) {
  if (width < 600) {
    return ScreenSize.Small;
  } else if (width < 900) {
    return ScreenSize.Medium;
  } else {
    return ScreenSize.Large;
  }
}
