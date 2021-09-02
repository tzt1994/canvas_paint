import 'package:canvas_paint/ui/canvas/draw/draw_circle_arc_oval.dart';
import 'package:canvas_paint/ui/canvas/draw/draw_color.dart';
import 'package:canvas_paint/ui/canvas/draw/draw_image.dart';
import 'package:canvas_paint/ui/canvas/draw/draw_point_line.dart';
import 'package:canvas_paint/ui/canvas/draw/draw_rect.dart';
import 'package:canvas_paint/ui/canvas/draw/draw_shadow.dart';
import 'package:canvas_paint/common/common_widget.dart';
import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Description: draw api方法
///
/// @author tangzhentao 
/// @date 2020/8/3 

class CanvasDrawPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CanvasDrawPageState();

}

class CanvasDrawPageState extends State<CanvasDrawPage> with SingleTickerProviderStateMixin {
  var tabs = ['drawColor', 'drawRect', 'drawCircle/Arc/Oval', 'drawPoint/Line', 'drawShadow', 'drawImage'];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cpAppBar(
        context,
        title: 'Canvas drawXXX()',
        bottom: TabBar(
          controller: _controller,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: ColorUtils.white,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          DrawColorPage(),
          DrawRectPage(),
          DrawCircleArcOvalPage(),
          DrawPointLinePage(),
          DrawShadowPage(),
          DrawImagePage(),
        ],
      ),
    );
  }

}