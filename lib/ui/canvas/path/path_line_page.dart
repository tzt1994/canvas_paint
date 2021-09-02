
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions:
/// User: tangzhentao
/// Date: 9:15 上午 2021/8/30
///

class PathLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('绘制线段, moveTo(),lineTo(),close()', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('moveTo(double x, double y), 移动点，下一段路径的起点\n'
              'lineTo(double x, double y), 连线至相对于原点的(x,y)偏移量的点\n'
              'close() 闭合当前Path, 即首尾连接\n'),
          Text('画笔的Style = PaintingStyle.stroke', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathLinePainter(),
          ),
          SizedBox(height: 10.w,),
          Text('画笔的Style = PaintingStyle.fill', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathLinePainter(style: PaintingStyle.fill),
          ),
          SizedBox(height: 10.w,),
          Text('闭合path', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathLinePainter(close: true),
          ),
          SizedBox(height: 30.w,),
          Text('relativeXXX()', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('连线至相对于上一个点偏移量为传入参数的方法'),
        ],
      ),
    );
  }

}

class _PathLinePainter extends CustomPainter {
  final Paint _savePaint = Paint()..isAntiAlias = true;
  final Paint _paint = Paint()
    ..isAntiAlias = true
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final Path _path = Path();

  bool close;

  _PathLinePainter({this.close = false, PaintingStyle style = PaintingStyle.stroke}) {
    _paint.style = style;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _savePaint);
    canvas.drawColor(Colors.red, BlendMode.color);
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontWeight: FontWeight.w300,
      fontSize: 14.sp,
      fontStyle: FontStyle.normal
    ));
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    pb.addText('close:$close');
    ui.Paragraph ph = pb.build()..layout(ui.ParagraphConstraints(width: 100.w));
    canvas.drawParagraph(ph, Offset(5, size.height / 2));
    _path.moveTo(size.width / 4, size.height / 4);
    _path.lineTo(size.width / 4 * 3, size.height / 4);
    _path.lineTo(size.width / 2, size.height / 8 * 7);
    if (close) _path.close();
    canvas.drawPath(_path, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PathLinePainter oldDelegate) => this != oldDelegate;
}