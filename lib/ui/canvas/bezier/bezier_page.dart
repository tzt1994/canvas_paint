import 'package:canvas_paint/ui/canvas/bezier/circle_bezier_page.dart';
import 'package:canvas_paint/ui/canvas/bezier/diy/circle_to_heart_bezier_page.dart';
import 'package:canvas_paint/ui/canvas/bezier/diy/diy_bezier_page.dart';
import 'package:canvas_paint/ui/canvas/bezier/multi_bezier_page.dart';
import 'package:canvas_paint/ui/canvas/bezier/one_bezier_page.dart';
import 'package:canvas_paint/ui/canvas/bezier/three_bezier_page.dart';
import 'package:canvas_paint/ui/canvas/bezier/two_bezier_page.dart';
import 'package:canvas_paint/common/common_widget.dart';
import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 11:09 上午 2021/8/25
///

class BezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BezierPageState();

}

class _BezierPageState extends State<BezierPage> with SingleTickerProviderStateMixin {
  var tabs = ['一阶贝塞尔', '二阶贝塞尔', '三阶贝塞尔', 'n阶贝塞尔', '贝塞尔实现圆形', '贝塞尔DIY', '贝塞尔实现圆变心'];
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cpAppBar(
        context,
        title: '贝塞尔曲线',
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
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          OneBezierPage(),
          TwoBezierPage(),
          ThreeBezierPage(),
          MultiBezierPage(),
          CircleBezierPage(),
          DiyBezierPage(),
          CircleToHeartBezierPage(),
        ],
      ),
    );
  }

}