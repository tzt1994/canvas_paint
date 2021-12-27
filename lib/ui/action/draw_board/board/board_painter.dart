import 'package:canvas_paint/ui/action/draw_board/board/board_controller.dart';
import 'package:flutter/material.dart';

/// Descriptions: 画板自定义
/// User: tangzhentao
/// Date: 11:11 上午 2021/9/8
///

class BoardPainter extends CustomPainter {
  final BoardController controller;

  BoardPainter({required this.controller}):super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => this != oldDelegate;

}