import 'package:canvas_paint/ui/action/draw_board/background/background_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/board_config.dart';
import 'package:flutter/material.dart';

/// Descriptions: 背景画笔
/// User: tangzhentao
/// Date: 11:06 上午 2021/9/8
///

class BackgroundPainter extends CustomPainter {
  final BackgroundController controller;

  final Paint _paint = Paint()..isAntiAlias = true;

  BackgroundPainter({required this.controller}):super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    if (controller.shading != Shading.none) {
      _drawShading(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => this != oldDelegate;

  /// 绘制背景色
  void _drawBackground(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _paint);
    canvas.drawColor(controller.bgColor, BlendMode.color);
    canvas.restore();
  }

  /// 绘制底纹
  void _drawShading(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _paint);
    switch (controller.shading) {
      case Shading.horizontal:
        break;
      case Shading.horizontal:
        break;
      case Shading.horizontal:
        break;
      case Shading.horizontal:
        break;
      default:
        break;
    }
    canvas.restore();
  }
}