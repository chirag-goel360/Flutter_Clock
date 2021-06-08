import 'package:flutter/foundation.dart';
import 'package:flutter_clock/helper/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(
    this.menuType, {
    this.title,
    this.imageSource,
  });

  onchangeMenuInfo(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;
    notifyListeners();
  }
}
