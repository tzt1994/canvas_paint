import 'package:canvas_paint/common/common_widget.dart';
import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:canvas_paint/ui/canvas/transform/clip_page.dart';
import 'package:canvas_paint/ui/canvas/transform/matrix4_page.dart';
import 'package:canvas_paint/ui/canvas/transform/transform_page.dart';
import 'package:flutter/material.dart';

/// Descriptions: 变化
/// User: tangzhentao
/// Date: 2:18 下午 2021/5/29
///

class CanvasTransformPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CanvasTransformPageState();

}

class _CanvasTransformPageState extends State<CanvasTransformPage> with SingleTickerProviderStateMixin {
  var tabs = ['canvas clip', 'canvas 几何变换', 'Matrix4 三维变换'];
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
        title: '裁剪和几何变换',
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
          ClipPage(),
          TransformPage(),
          Matrix4Page(),
        ],
      ),
    );
  }

}