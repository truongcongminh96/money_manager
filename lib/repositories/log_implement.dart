import 'package:money_manager/repositories/log.dart';

class LogImplement implements Log {
  bool isDebug = true;

  @override
  void debug(String tag, String content) {
    if (isDebug) print("[$tag] $content");
  }

  @override
  void error(String tag, String content) {
    print("[Error][$tag] $content");
  }

  @override
  void infor(String tag, String content) {
    print("[$tag] $content");
  }
}
