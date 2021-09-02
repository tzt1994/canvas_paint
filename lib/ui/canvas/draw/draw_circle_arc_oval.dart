import 'dart:ui' as ui;

import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:canvas_paint/common/utils/cp_extensions.dart';

/// Description: 绘制圆或圆弧或椭圆
///
/// @author tangzhentao 
/// @date 2020/8/4 

enum DrawType {
  circle, arc, oval
}

class DrawCircleArcOvalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawCircleArcOvalPageState();

}

class DrawCircleArcOvalPageState extends State<DrawCircleArcOvalPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.w),
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10.w, bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'drawCircle(Offset c, double radius, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '绘制圆\nc:圆的中心\nradius:圆的半径\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(paintingStyle: PaintingStyle.stroke),
            ),
            SizedBox(height: 10.w,),
            Text(
              'drawOval(Rect rect, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '绘制椭圆\nrect:椭圆的矩形范围\nui.paint: 画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(type: DrawType.oval, color: Colors.red),
            ),
            SizedBox(height: 10.w,),
            Text(
              'drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '绘制圆弧\nrect:圆滑的矩形范围\nstartAngle:圆弧开始的弧度值\nsweepAngle:扇形扫过的弧度值\nuseCenter:是否闭合圆弧\nui.paint: 画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(type: DrawType.arc, color: Colors.blue),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(type: DrawType.arc, color: Colors.blue, paintingStyle: PaintingStyle.stroke, userCenter: true),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(type: DrawType.arc, color: Colors.green, userCenter: true),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawCircleArcPainter(type: DrawType.arc, paintingStyle: PaintingStyle.stroke, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

}

class DrawCircleArcPainter extends CustomPainter {
  late Color textColor;
  late Color color;
  late PaintingStyle paintingStyle;
  late bool userCenter;
  late DrawType type;
  final colorPaint = Paint()
    ..isAntiAlias = true;

  DrawCircleArcPainter({this.userCenter = false, this.textColor = Colors.black, this.color = Colors.red, this.paintingStyle = PaintingStyle.fill, this.type = DrawType.circle}) {
    colorPaint..color = color
        ..style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (type != DrawType.oval) {
      ui.ParagraphBuilder pb = ui.ParagraphBuilder(
          ui.ParagraphStyle(
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w300,
            fontSize: 14.sp,
            fontStyle: FontStyle.normal,
          )
      );
      pb.pushStyle(ui.TextStyle(color: textColor, textBaseline: ui.TextBaseline.alphabetic));
      pb.addText(paintingStyle.toString());
      ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: double.infinity));
      canvas.drawParagraph(paragraph, Offset(15.w, type == DrawType.circle ? size.height / 2 : size.height / 4));
    }
    switch (type) {
      case DrawType.circle:
        canvas.drawCircle(Offset(size.centerX, size.centerY), size.height / 2, colorPaint);
        break;
      case DrawType.oval:
        colorPaint.color = Colors.red;
        canvas.drawOval(Rect.fromLTRB(0, size.height / 4, size.width / 4 , size.height / 4 * 3), colorPaint);
        colorPaint.color = Colors.green;
        canvas.drawOval(Rect.fromLTRB(size.width / 2 - size.height / 4, 0, size.width / 2 + size.height / 4 , size.height), colorPaint);
        colorPaint.color = Colors.blue;
        canvas.drawOval(Rect.fromLTRB(size.width - size.height - 10.w, 0, size.width - 10.w , size.height), colorPaint);
        break;
      case DrawType.arc:
        ui.ParagraphBuilder pb2 = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb2.pushStyle(ui.TextStyle(color: textColor, textBaseline: ui.TextBaseline.alphabetic));
        pb2.addText("useCenter: ${userCenter.toString()}");
        ui.Paragraph paragraph2 = pb2.build()..layout(ui.ParagraphConstraints(width: double.infinity));
        canvas.drawParagraph(paragraph2, Offset(15.w, size.height / 4 * 3));
        canvas.drawArc(Rect.fromLTRB(size.centerX - size.height / 2, 0, size.centerX + size.height / 2, size.height), -90.toRadian, 100.toRadian, userCenter, colorPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(DrawCircleArcPainter oldDelegate) => this != oldDelegate;

}