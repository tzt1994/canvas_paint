import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 667),
      builder: () => MaterialApp(
        navigatorKey: navKey,
        title: 'Canvas Paint',
        theme: ThemeData(
            primaryColor: ColorUtils.theme,
            backgroundColor: ColorUtils.color_f0f0f8
        ),
        home: HomePage(),
      ),
    );
  }
}
