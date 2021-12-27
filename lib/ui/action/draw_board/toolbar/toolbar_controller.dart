import 'package:flutter/material.dart';

import '../board_config.dart';

/// Descriptions: 工具栏控制器
/// User: tangzhentao
/// Date: 2:36 下午 2021/9/10
///

class ToolbarController extends ChangeNotifier {

  /// 当前模式
  DrawMode _drawMode = DrawMode.pen;
  DrawMode get drawMode => _drawMode;
  set drawMode(DrawMode mode) {
    if (_drawMode != mode) {
      print('选择新的$mode');
      _drawMode = mode;
      notifyListeners();
    }
  }
}