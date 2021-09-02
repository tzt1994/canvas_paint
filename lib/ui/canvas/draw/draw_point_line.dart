import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:canvas_paint/common/utils/cp_extensions.dart';

/// Description: 绘制圆或椭圆或圆弧
///
/// @author tangzhentao 
/// @date 2020/8/4 

enum DrawType {
  point, rawPoints, line
}

class DrawPointLinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawPointLinePageState();

}

class DrawPointLinePageState extends State<DrawPointLinePage> {

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
              'drawPoints(PointMode pointMode, List<Offset> points, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '绘制多个点，忽略PaintStyle\npointMode:绘制点模式\npoints:点集合\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(des: '画点'),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(pointMode: ui.PointMode.lines, des: '画线，点下标为奇数不画线', color: Colors.green),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(pointMode: ui.PointMode.polygon, des: '连线，用线将点连起来', color: Colors.blue),
            ),
            SizedBox(height: 10.w,),
            Text(
              'drawRawPoints(PointMode pointMode, Float32List points, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '绘制多个点，忽略PaintStyle\npointMode:绘制点模式\npoints:点集合\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(type: DrawType.rawPoints, color: Colors.red),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(type: DrawType.rawPoints, color: Colors.green, pointMode: ui.PointMode.lines),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(type: DrawType.rawPoints, color: Colors.blue, pointMode: ui.PointMode.polygon),
            ),
            Text(
              'drawLine(Offset p1, Offset p2, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '绘制线段\np1:起点\np2:终点\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(type: DrawType.line, color: Colors.red, strokeWidth: 7),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawPointLinePainter(type: DrawType.line, color: Colors.green, paintingStyle: PaintingStyle.stroke, strokeWidth: 10),
            ),
          ],
        ),
      ),
    );
  }

}

class DrawPointLinePainter extends CustomPainter {
  late Color textColor;
  late Color color;
  late String des;
  late PaintingStyle paintingStyle;
  late ui.PointMode pointMode;
  late DrawType type;
  late double strokeWidth;
  final colorPaint = Paint()
    ..isAntiAlias = true;

  final List<Offset> offsets = [];
  late Float32List points;

  DrawPointLinePainter({this.strokeWidth = 5, this.des = '', this.pointMode = ui.PointMode.points, this.textColor = Colors.black, this.color = Colors.red, this.paintingStyle = PaintingStyle.fill, this.type = DrawType.point}) {
    colorPaint..color = color
        ..style = paintingStyle
        ..strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case DrawType.point:
        ui.ParagraphBuilder pb = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb.pushStyle(ui.TextStyle(color: textColor, textBaseline: ui.TextBaseline.alphabetic));
        pb.addText("${pointMode.toString()}$des");
        ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: size.width / 8 * 3));
        canvas.drawParagraph(paragraph, Offset(5.w, size.height / 4));
        colorPaint..style = PaintingStyle.stroke;
        canvas.drawPoints(pointMode, [Offset(size.width / 8 * 3, size.height / 8), Offset(size.width / 2, size.height / 2), Offset(size.width / 8 * 5, size.height / 8 * 5),  Offset(size.width / 4 * 3, size.height / 4), Offset(size.width / 8 * 7, size.height / 7)], colorPaint);
        break;
      case DrawType.rawPoints:
        ui.ParagraphBuilder pb2 = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb2.pushStyle(ui.TextStyle(color: textColor, textBaseline: ui.TextBaseline.alphabetic));
        pb2.addText("${pointMode.toString()}");
        ui.Paragraph paragraph2 = pb2.build()..layout(ui.ParagraphConstraints(width: size.width / 8 * 3));
        canvas.drawParagraph(paragraph2, Offset(5.w, size.height / 4));
        colorPaint..style = PaintingStyle.stroke;
        canvas.drawRawPoints(pointMode, Float32List.fromList([size.width / 8 * 3, size.height / 8, size.width / 2, size.height / 2, size.width / 8 * 5, size.height / 8 * 5, size.width / 4 * 3, size.height / 4, size.width / 8 * 7, size.height / 7]), colorPaint);
        break;
      case DrawType.line:
        ui.ParagraphBuilder pb3 = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb3.pushStyle(ui.TextStyle(color: textColor, textBaseline: ui.TextBaseline.alphabetic));
        pb3.addText("${paintingStyle.toString()}");
        ui.Paragraph paragraph3 = pb3.build()..layout(ui.ParagraphConstraints(width: size.width / 8 * 3));
        canvas.drawParagraph(paragraph3, Offset(5.w, size.height / 4));
        canvas.drawLine(Offset(size.width / 8 * 3, size.height / 4), Offset(size.width / 4 * 3, size.height / 4 * 3), colorPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(DrawPointLinePainter oldDelegate) => this != oldDelegate;

}