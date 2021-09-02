import 'dart:ui' as ui;

import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:canvas_paint/common/utils/cp_extensions.dart';

/// Description: 绘制阴影
///
/// @author tangzhentao 
/// @date 2020/8/4 

class DrawShadowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawShadowPageState();

}

class DrawShadowPageState extends State<DrawShadowPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 10.w),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'drawShadow(Path path, Color color, double elevation, bool transparentOccluder)',
            style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            '绘制阴影\npath: 目标路径\ncolor: 阴影颜色\nelevation: 阴影大小\ntransparentOccluder: 是否绘制背景颜色',
            style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp,),
          ),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: DrawShadowPainter(color: Colors.red, transparentOccluder: true),
          ),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: DrawShadowPainter(color: Colors.green),
          ),
        ],
      ),
    );
  }

}

class DrawShadowPainter extends CustomPainter {
  late Color textColor;
  late Color color;
  late bool transparentOccluder;
  final colorPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.black;

  final Path path = Path();

  DrawShadowPainter({this.transparentOccluder = false, this.color = Colors.red, this.textColor = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w300,
        fontSize: 14.sp,
        fontStyle: FontStyle.normal,
      )
    );
    pb.pushStyle(ui.TextStyle(color: Color(0xff000000)));
    pb.addText('Color:${color.toArgb}    ${transparentOccluder.toString()}');
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: double.infinity));
    canvas.drawParagraph(paragraph, Offset(10.w, 15.w - paragraph.height / 2));
    path.reset();
    path.addRect(Rect.fromLTRB(20.w, 20.w, size.width - 20.w, size.height - 20.w));
    canvas.drawShadow(path, color, 2.w, transparentOccluder);
  }

  @override
  bool shouldRepaint(DrawShadowPainter oldDelegate) => this != oldDelegate;

}