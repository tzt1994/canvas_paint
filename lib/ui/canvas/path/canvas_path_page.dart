import 'package:canvas_paint/ui/canvas/path/path_line_page.dart';
import 'package:canvas_paint/ui/canvas/path/path_operation_page.dart';
import 'package:canvas_paint/ui/canvas/path/path_shape_page.dart';
import 'package:canvas_paint/common/common_widget.dart';
import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Descriptions: path
/// User: tangzhentao
/// Date: 2:18 下午 2021/5/29
///

class CanvasPathPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CanvasPathPageState();

}

class _CanvasPathPageState extends State<CanvasPathPage> with SingleTickerProviderStateMixin {
  var tabs = ['绘制线段', 'addXXX()', 'path操作'];
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
          PathLinePage(),
          PathShapePage(),
          PathOperationPage(),
        ],
      ),
    );
  }

}