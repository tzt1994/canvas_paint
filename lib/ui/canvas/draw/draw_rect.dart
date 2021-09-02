import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Description: drawRect系列方法
///
/// @author tangzhentao 
/// @date 2020/8/4 


enum RectType{
  rect, round, dRRect
}

class DrawRectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawRectPageState();

}

class DrawRectPageState extends State<DrawRectPage> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomPaint(
            size: Size(double.infinity, 60.h),
            painter: DrawRectPainter(text: "drawRect(Rect rect, Paint ui.paint)\n绘制矩形,fill"),
          ),
          CustomPaint(
            size: Size(double.infinity, 60.h),
            painter: DrawRectPainter(text: "drawRect(Rect rect, Paint ui.paint)\n绘制矩形,stroke", paintingStyle: PaintingStyle.stroke),
          ),
          CustomPaint(
            size: Size(double.infinity, 60.h),
            painter: DrawRectPainter(text: "drawRRect(RRect rRect, Paint ui.paint)\n绘制圆角矩形, fill", rectType: RectType.round),
          ),
          CustomPaint(
            size: Size(double.infinity, 60.h),
            painter: DrawRectPainter(text: "drawRRect(RRect rRect, Paint ui.paint)\n绘制圆角矩形, stroke", paintingStyle: PaintingStyle.stroke, rectType: RectType.round),
          ),
          CustomPaint(
            size: Size(double.infinity, 80.h),
            painter: DrawRectPainter(text: "drawDRRect(RRect outer, RRect inner, Paint ui.paint)\n绘制由两个圆角矩形之间的差异组成的形状,fill", rectType: RectType.dRRect),
          ),
          CustomPaint(
            size: Size(double.infinity, 80.h),
            painter: DrawRectPainter(text: "drawDRRect(RRect outer, RRect inner, Paint ui.paint)\n绘制由两个圆角矩形之间的差异组成的形状,stroke", paintingStyle: PaintingStyle.stroke, rectType: RectType.dRRect),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}

class DrawRectPainter extends CustomPainter {
  RectType rectType;
  PaintingStyle paintingStyle;
  String text;
  Color textColor;
  Color rectColor;
  final colorPaint = Paint()..isAntiAlias = true;

  DrawRectPainter({this.rectType = RectType.rect, this.paintingStyle = PaintingStyle.fill, this.text = "", this.textColor = Colors.black, this.rectColor = Colors.blue}) {
    colorPaint.color = rectColor;
    colorPaint.style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w300,
          fontSize: 14.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pb.pushStyle(ui.TextStyle(color: textColor, textBaseline: ui.TextBaseline.ideographic));
    pb.addText(text);
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: double.infinity));
    switch (rectType) {
      case RectType.rect:
        canvas.drawRect(Rect.fromLTRB(10.w, 10.w, size.width - 10.w, size.height- 10.w), colorPaint);
        break;
      case RectType.round:
        canvas.drawRRect(RRect.fromLTRBR(10.w, 10.w, size.width - 10.w, size.height- 10.w, Radius.circular(10.w)), colorPaint);
        break;
      case RectType.dRRect:
        canvas.drawDRRect(RRect.fromLTRBR(10.w, 10.w, size.width - 10.w, size.height- 10.w, Radius.circular(10.w)),
            RRect.fromLTRBR(30.w, 30..w, size.width - 30.w, size.height- 30.w, Radius.circular(20.w)), colorPaint);
        break;
    }
    canvas.drawParagraph(paragraph, Offset(15.w, 15.w));
  }

  @override
  bool shouldRepaint(DrawRectPainter oldDelegate) => this != oldDelegate;

}