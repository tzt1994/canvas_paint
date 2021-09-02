import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: 坐标系
/// User: tangzhentao
/// Date: 11:18 上午 2021/8/25
///

class CoordinatePainter extends CustomPainter {
  final Paint _paint = Paint()
    ..isAntiAlias = true;
  /// 线画笔
  final Paint _linePaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke
    ..color = Colors.grey;
  /// 刻度画笔
  final Paint _tableLinePaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = Color(0xFFF1F1F1);

  @override
  void paint(Canvas canvas, Size size) {
    final halfH = size.height / 2;
    final halfW = size.width / 2;
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _paint);
    /// 绘制十字线
    /// 画布原点平移
    canvas.translate(halfW, halfH);
    /// 绘制横坐标(正值)
    var xRight = 0.0;
    do {
      xRight += 25;
      /// 绘制网格线
      canvas.drawLine(Offset(xRight, -halfH), Offset(xRight, halfH), _tableLinePaint);
      /// 绘制刻度线
      canvas.drawLine(Offset(xRight, 0), Offset(xRight, -8), _linePaint);
      /// 绘制整百刻度值
      if (xRight % 50 == 0) {
        ui.ParagraphBuilder pb = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb.pushStyle(ui.TextStyle(color: Colors.grey));
        pb.addText('${xRight.toInt()}');
        ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: 30));
        canvas.drawParagraph(paragraph, Offset(xRight - paragraph.width / 2, 5));
      }
    } while (xRight < halfW);
    /// 绘制横坐标(负值)
    var xLeft = 0.0;
    do {
      xLeft -= 25;
      /// 绘制网格线
      canvas.drawLine(Offset(xLeft, -halfH), Offset(xLeft, halfH), _tableLinePaint);
      /// 绘制刻度线
      canvas.drawLine(Offset(xLeft, 0), Offset(xLeft, -8), _linePaint);
      /// 绘制整百刻度值
      if (xLeft % 50 == 0) {
        ui.ParagraphBuilder pb = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb.pushStyle(ui.TextStyle(color: Colors.grey));
        pb.addText('${xLeft.toInt()}');
        ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: 45));
        canvas.drawParagraph(paragraph, Offset(xLeft - paragraph.width / 2, 5));
      }
    } while (xLeft > -halfW);
    /// 绘制纵坐标(负值)
    var yTop = 0.0;
    do {
      yTop -= 25;
      /// 绘制网格线
      canvas.drawLine(Offset(-halfW, yTop), Offset(halfW, yTop), _tableLinePaint);
      /// 绘制刻度线
      canvas.drawLine(Offset(0, yTop), Offset(-8, yTop), _linePaint);
      /// 绘制整百刻度值
      if (yTop % 50 == 0) {
        ui.ParagraphBuilder pb = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb.pushStyle(ui.TextStyle(color: Colors.grey));
        pb.addText('${yTop.toInt()}');
        ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: 45));
        canvas.drawParagraph(paragraph, Offset(-paragraph.width, yTop - paragraph.height / 2));
      }
    } while (yTop > -halfH);
    /// 绘制纵坐标(正值)
    var yBottom = 0.0;
    do {
      yBottom += 25;
      /// 绘制网格线
      canvas.drawLine(Offset(-halfW, yBottom), Offset(halfW, yBottom), _tableLinePaint);
      /// 绘制刻度线
      canvas.drawLine(Offset(0, yBottom), Offset(-8, yBottom), _linePaint);
      /// 绘制整百刻度值
      if (yBottom % 50 == 0) {
        ui.ParagraphBuilder pb = ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              fontStyle: FontStyle.normal,
            )
        );
        pb.pushStyle(ui.TextStyle(color: Colors.grey));
        pb.addText('${yBottom.toInt()}');
        ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: 45));
        canvas.drawParagraph(paragraph, Offset(-paragraph.width, yBottom - paragraph.height / 2));
      }
    } while (yBottom < halfH);
    /// 绘制十字线
    canvas.drawLine(Offset(-halfW, 0), Offset(halfW, 0), _linePaint);
    canvas.drawLine(Offset(0, -halfH), Offset(0, halfH), _linePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CoordinatePainter oldDelegate) => this != oldDelegate;

}