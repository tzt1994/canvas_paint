import 'package:flutter/material.dart';

import '../board_config.dart';

/// Descriptions: 画板控制器
/// User: tangzhentao
/// Date: 11:12 上午 2021/9/8
///

class BoardController extends ChangeNotifier {
  /// 当前模式
  DrawMode _drawMode = DrawMode.pen;
  DrawMode get drawMode => _drawMode;
  set drawMode(DrawMode mode) {
    if (_drawMode != mode) {
      _drawMode = mode;
    }
  }

}