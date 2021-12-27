import 'package:flutter/material.dart';

/// Descriptions: 画板配置
/// User: tangzhentao
/// Date: 11:27 上午 2021/9/8
///

final boardTheme = Color(0xFF129F72);

/// 背景颜色集合
final bgColorList = [Color(0xFF0A392A), Color(0xFF4B5750), Color(0xFF0F464C), Color(0xFF0065B2), Colors.white,];

/// 底纹
enum Shading {
  /// 无底纹
  none,
  /// 拼音/英语
  horizontal,
  /// 田字格/十字线
  cross,
  /// 米字格
  cross_opposite,
  /// 拼音+汉字
  horizontal_cross
}

/// 绘制模式
enum DrawMode {
  choice,pen,rubber,shape,background,revoke,screen_shot,recovery
}

/// 线粗细
final boardLineSizeList = [2, 4, 6];

/// 线颜色集合
final boardLineColorList = [
  Color(0xFFE51101), Color(0xFFFFAF10), Color(0xFF3866E5), Color(0xFF191919),
  Color(0xFF269A99), Color(0xFF6DC8EC), Color(0xFF9270CA), Color(0xFFFFFFFF),
];