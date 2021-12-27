
import 'package:canvas_paint/res.dart';
import 'package:canvas_paint/ui/action/action_page.dart';
import 'package:canvas_paint/ui/canvas/canvas_page.dart';
import 'package:canvas_paint/ui/paint/paint_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/utils/color_utils.dart';

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/3 

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _controller;
  var titles = ['Action', 'Canvas', 'Paint'];
  var images = [Res.action, Res.canvas, Res.paint];
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _controller = TabController(length: titles.length, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_controller.index]),
      ),
      body: TabBarView(
        children: <Widget>[
          ActionPage(),
          CanvasPage(),
          PaintPage(),
        ],
        controller: _controller,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _controller.index,
        items: titles.map((element) {
          var image = images[titles.indexOf(element)];
          return BottomNavigationBarItem(
              icon: Image.asset(
                image,
                color: ColorUtils.text_1,
                width: 24.h,
                height: 24.h,
              ),
              activeIcon: Image.asset(
                image,
                color: ColorUtils.theme,
                width: 24.h,
                height: 24.h,
              ),
              title: Text(element, style: TextStyle(fontSize: 16.sp, color: _controller.index == titles.indexOf(element) ? ColorUtils.theme : ColorUtils.text_1),)
          );
        }).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.animateTo(index);
          setState(() {});
        },
      ),
    );
  }

}