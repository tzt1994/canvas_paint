import 'package:canvas_paint/ui/action/draw_board/board_config.dart';
import 'package:flutter/material.dart';

/// Descriptions: 背景控制器
/// User: tangzhentao
/// Date: 11:04 上午 2021/9/8
///

class BackgroundController extends ChangeNotifier {
  /// 背景颜色
  Color _bgColor =  bgColorList[0];
  Color get bgColor => _bgColor;
  set bgColor(Color color) {
    if (_bgColor != color) {
      _bgColor = color;
      notifyListeners();
    }
  }

  /// 底纹
  Shading _shading = Shading.none;
  Shading get shading => _shading;
  set shading(Shading sha) {
    if (_shading != sha) {
      _shading = sha;
      notifyListeners();
    }
  }
}