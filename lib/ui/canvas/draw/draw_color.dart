import 'dart:ui' as ui;

import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:canvas_paint/common/utils/cp_extensions.dart';

/// Description: 绘制颜色
///
/// @author tangzhentao 
/// @date 2020/8/4 

class DrawColorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawColorPageState();

}

class DrawColorPageState extends State<DrawColorPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.w),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'drawColor(Color color, BlendMode blendMode)\n绘制颜色，blendModel颜色叠加显示模式',
            style: TextStyle(color: ColorUtils.text_1, fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.green, textColor: Colors.black, blendMode: BlendMode.clear),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.red, blendMode: BlendMode.exclusion),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.green, blendMode: BlendMode.color),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.blue, blendMode: BlendMode.colorBurn),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.redAccent, blendMode: BlendMode.colorDodge),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.greenAccent, blendMode: BlendMode.softLight),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.blueAccent, blendMode: BlendMode.hardLight),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.amber, blendMode: BlendMode.lighten),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.deepOrange, blendMode: BlendMode.darken),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.purple, blendMode: BlendMode.difference),
                ),CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.purpleAccent, blendMode: BlendMode.hue),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.deepPurple, blendMode: BlendMode.luminosity),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.deepPurpleAccent, blendMode: BlendMode.modulate),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.deepOrange, blendMode: BlendMode.multiply),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.deepOrangeAccent, blendMode: BlendMode.overlay),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.blue, blendMode: BlendMode.plus),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.blueAccent, blendMode: BlendMode.saturation),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.lightBlue, blendMode: BlendMode.screen),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.lightBlueAccent, blendMode: BlendMode.xor),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.green, blendMode: BlendMode.dst),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.green, blendMode: BlendMode.dstATop),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.greenAccent, blendMode: BlendMode.dstIn),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.lightGreen, blendMode: BlendMode.dstOut),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.lightGreenAccent, blendMode: BlendMode.dstOver),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.red, blendMode: BlendMode.src),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.red, blendMode: BlendMode.srcATop),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.redAccent, blendMode: BlendMode.srcIn),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.pink, blendMode: BlendMode.srcOut),
                ),
                CustomPaint(
                  size: Size(double.infinity, 30.h),
                  painter: DrawColorPainter(color: Colors.pinkAccent, blendMode: BlendMode.srcOver),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

}

class DrawColorPainter extends CustomPainter {
  late Color textColor;
  late Color color;
  late BlendMode blendMode;
  final colorPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.black;

  DrawColorPainter({this.color = Colors.red, this.blendMode = BlendMode.clear, this.textColor = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), colorPaint);
    canvas.drawColor(color, blendMode);
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w300,
        fontSize: 14.sp,
        fontStyle: FontStyle.normal,
      )
    );
    pb.pushStyle(ui.TextStyle(color: Color(0xff000000)));
    pb.addText('Color:${color.toArgb}    ${blendMode.toString()}');
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: double.infinity));
    canvas.drawParagraph(paragraph, Offset(10.w, 15.w - paragraph.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(DrawColorPainter oldDelegate) => this.blendMode != oldDelegate.blendMode || this.color != oldDelegate.color;

}