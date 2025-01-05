import 'package:fluttertoast/fluttertoast.dart';

import 'app_color.dart';

Future<void> commonToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.cBackGround,
    textColor: AppColor.cText,
    fontSize: 16.0,
  );
}