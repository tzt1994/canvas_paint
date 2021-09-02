
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:canvas_paint/common/utils/cp_extensions.dart';

/// Descriptions: 形状
/// User: tangzhentao
/// Date: 9:15 上午 2021/8/30
///

class PathShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, ScreenUtil().bottomBarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('绘制矩形, addRect(Rect rect)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('rect:矩形参数'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(),
          ),
          SizedBox(height: 20.w,),
          Text('绘制圆角矩形, addRRect(RRect rrect)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('rrect:圆角矩形参数'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.rRect),
          ),
          SizedBox(height: 20.w,),
          Text('绘制椭圆，根据传入的rect进行绘制, addOval(Rect oval))', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('oval:椭圆所在的矩形参数'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.oval),
          ),
          SizedBox(height: 20.w,),
          Text('绘制弧形，根据传入的rect进行绘制,addArc(Rect oval, double startAngle, double sweepAngle)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('oval:弧形所在的矩形参数\n'
              'startAngle: 开始的弧度值(需要将角度值转为弧度值)\n'
              'sweepAngle:弧形扫过的弧度值(需要将角度值转为弧度值)'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.arc),
          ),
          Text('PaintingStyle.fill效果，绘制扇形'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.arc, style: PaintingStyle.fill),
          ),
          SizedBox(height: 20.w,),
          Text('绘制弧形，arcTo(Rect rect, double startAngle, double sweepAngle, bool forceMoveTo)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('rect:弧形所在的矩形参数\n'
              'startAngle: 开始的弧度值(需要将角度值转为弧度值)\n'
              'sweepAngle:弧形扫过的弧度值(需要将角度值转为弧度值)\n'
              'forceMoveTwo:false为闭合弧形'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.arcTo),
          ),
          SizedBox(height: 20.w,),
          Text('绘制圆角，arcToPoint(Offset arcEnd, {\n'
              'Radius radius = Radius.zero,\ndouble rotation = 0.0,\nbool largeArc = false,\nbool clockwise = true,})\n'
              '会在上一个起点开始，以offset为终点，参照半径 radius 计算出一个path(clock和largeArc扫过的角度值不超过360度)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('arcEnd:终点\n'
              'radius: 半径\n'
              'rotation:旋转值\n'
              'largeArc:是否取大的部分弧形\n'
              'clockwise:顺/逆时针'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.arcToPoint),
          ),
          SizedBox(height: 20.w,),
          Text('绘制多边形,addPolygon(List<Offset> points, bool close)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('points:多边形的点数据\n'
              'close: 是否闭合path\n'),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathShapePainter(shapeType: ShapeType.polygon),
          ),
        ],
      ),
    );
  }

}

class _PathShapePainter extends CustomPainter {
  final Paint _savePaint = Paint()..isAntiAlias = true;
  final Paint _paint = Paint()
    ..isAntiAlias = true
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final Path _path = Path();

  ShapeType shapeType;

  _PathShapePainter({this.shapeType = ShapeType.rect, PaintingStyle style = PaintingStyle.stroke}) {
    _paint.style = style;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _savePaint);
    canvas.drawColor(Colors.green, BlendMode.color);
    // ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
    //   textAlign: TextAlign.left,
    //   fontWeight: FontWeight.w300,
    //   fontSize: 14.sp,
    //   fontStyle: FontStyle.normal
    // ));
    // pb.pushStyle(ui.TextStyle(color: Colors.white));
    // pb.addText('close:$close');
    // ui.Paragraph ph = pb.build()..layout(ui.ParagraphConstraints(width: 100.w));
    // ui.canvas.drawParagraph(ph, Offset(5, size.height / 2));
    switch(shapeType) {
      case ShapeType.rect:
        _path.addRect(Rect.fromLTRB(size.width / 5, size.height / 5, size.width / 5 * 4, size.height / 5 * 4));
        break;
      case ShapeType.rRect:
        _path.addRRect(RRect.fromLTRBR(size.width / 5, size.height / 5, size.width / 5 * 4, size.height / 5 * 4, Radius.circular(10.w)));
        break;
      case ShapeType.oval:
        _path.addOval(Rect.fromLTRB(size.width / 5, size.height / 5, size.width / 5 * 4, size.height / 5 * 4));
        break;
      case ShapeType.arc:
        _path.addArc(Rect.fromLTRB(size.width / 5, size.height / 5, size.width / 5 * 4, size.height / 5 * 4), -90.toRadian, 180.toRadian);
        break;
      case ShapeType.arcTo:
        _path.arcTo(Rect.fromLTRB(size.width / 5, size.height / 5, size.width / 5 * 4, size.height / 5 * 4), -90.toRadian, 180.toRadian, false);
        break;
      case ShapeType.arcToPoint:
        _path.addRect(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.height / 2, height: size.height / 2));
        _path.moveTo(size.width / 2, size.height / 4);
        _path.arcToPoint(Offset(size.width / 2, size.height / 2 + size.height / 4), radius: Radius.circular(size.height / 2),);
        break;
      case ShapeType.polygon:
        _path.addPolygon([
          Offset(size.width / 5, size.height / 2), Offset(size.width / 5 * 2, size.height / 6), Offset(size.width / 5 * 3, size.height / 6),
          Offset(size.width / 5 * 4, size.height / 2), Offset(size.width / 5 * 3, size.height / 6 * 5 ), Offset(size.width / 5 * 2, size.height / 6 * 5)
        ], true);
        break;
    }
    canvas.drawPath(_path, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PathShapePainter oldDelegate) => this != oldDelegate;
}

enum ShapeType {
  rect,rRect,oval,arc,arcTo, arcToPoint, polygon,
}