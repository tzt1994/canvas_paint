import 'dart:math';

import 'package:flutter/widgets.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 5:21 PM 4/14/21
///

extension SizeExtension on Size {
  Rect get toRect => Rect.fromLTRB(0, 0, width, height);

  double get centerX => width / 2;

  double get centerY => height / 2;
}

extension NumberExtension on num {
  /// 转成弧度制
  double get toRadian => this * pi / 180;
  /// 转成角度值
  double get toAngle => this * 180 / pi;
}

extension ColorExtension on Color {
  String get toArgb => "0x${this.alpha.toRadixString(16).toUpperCase()}${this.red.toRadixString(16).toUpperCase()}${this.green.toRadixString(16).toUpperCase()}${this.blue.toRadixString(16).toUpperCase()}";
}

