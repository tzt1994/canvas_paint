import 'package:canvas_paint/common/common_widget.dart';
import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/3 

class CustomPainterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomPainterPageState();

}

class CustomPainterPageState extends State<CustomPainterPage> {
  List<Offset> positions = [];
  var isClick = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cpAppBar(
        context,
        title: 'CustomPaint',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
        child: Column(
          children: <Widget>[
            Text(
              'CustomPainter',
              style: TextStyle(color: ColorUtils.text_1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
            Text(
              'CustomPainter是一个抽象类，需要继承来实现绘制逻辑和重绘条件\n'
                  '主要是\nui.paint(Canvas ui.canvas, Size size)\nbool shouldRepaint(CustomPainter oldDelegate)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            Container(
              color: ColorUtils.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                'void ui.paint(Canvas ui.canvas, Size size)',
                style: TextStyle(color: ColorUtils.text_2, fontSize: 14.sp),),
            ),
            Text(
              'Canvas: 画布，包含所有的绘制方法，在都是此画布上绘制。\n'
                  'Size: 当前绘制区域大小',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            Container(
              color: ColorUtils.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                'bool shouldRepaint(CustomPainter oldDelegate)',
                style: TextStyle(color: ColorUtils.text_2, fontSize: 14.sp),),
            ),
            Text(
              'oldDelegate: 旧的CustomPainter对象, 可以写成具体的类型，按照自己的业务的逻辑返回bool值进行重绘',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                'CustomPainter实现的五子棋',
                style: TextStyle(color: ColorUtils.theme, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 14.h,),
            Listener(
              onPointerDown: (PointerDownEvent event) {
                isClick = true;
              },
              onPointerMove: (PointerMoveEvent event) {
                isClick = false;
              },
              onPointerUp: (PointerUpEvent event) {
                if (isClick) {
                  print('点击 ${event.localPosition.dx}  ${event.localPosition.dy}');
                  positions.add(event.localPosition);
                  setState(() {
                  });
                }
              },
              child: CustomPaint(
                size: Size(300.w, 300.w),
                painter: GoBangBgPainter(lineWidth: 1.w),
                foregroundPainter: GoBangFlagPainter(positions),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 五子棋背景
class GoBangBgPainter extends CustomPainter {
  Paint bgPaint = Paint()..isAntiAlias = true
                          ..style = PaintingStyle.fill;
  Paint linePaint = Paint()..isAntiAlias = true
                            ..style = PaintingStyle.stroke;

  Color bgColor;
  Color lineColor;
  double lineWidth;

  GoBangBgPainter({
    this.lineColor = const Color(0xff000000),
    this.bgColor = const Color(0xFFFFCC80),
    this.lineWidth = 3,
  }) {
    bgPaint.color = bgColor;

    linePaint
      ..color = lineColor
      ..strokeWidth = lineWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var unit = size.width / 15;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), bgPaint);

    for (int i = 0; i <= 15; i++) {
      canvas.drawLine(Offset(i * unit, 0), Offset(i * unit, size.height), linePaint);
      canvas.drawLine(Offset(0, i * unit), Offset(size.width, i * unit), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// 五子棋棋子
class GoBangFlagPainter extends CustomPainter {
  late List<Offset> positions;

  bool blackFirst;
  Paint blackPaint = Paint()..color = Colors.black
                            ..style = PaintingStyle.fill
                            ..isAntiAlias = true;
  Paint whitePaint = Paint()..color = Colors.white
                            ..style = PaintingStyle.fill
                            ..isAntiAlias = true;

  GoBangFlagPainter(this.positions, {this.blackFirst = true});

  @override
  void paint(Canvas canvas, Size size) {
    var unit = size.width / 15;
    if (positions.length > 0) {
      for (Offset po in positions) {
        var x;
        var y;
        var yx = po.dx % unit;
        if (yx == 0) {
          x = po.dx;
        } else {
          if (yx < unit / 2) {
            x = po.dx - yx;
          } else {
            x = po.dx + (unit - yx);
          }
        }

        var yy = po.dy % unit;
        if (yy == 0) {
          y = po.dy;
        } else {
          if (yy < unit / 2) {
            y = po.dy - yy;
          } else {
            y = po.dy + (unit - yy);
          }
        }

        canvas.drawCircle(Offset(x, y), unit / 2, blackFirst && (positions.indexOf(po) + 1) % 2 != 0 ? blackPaint : whitePaint);
      }
    }
  }

  @override
  bool shouldRepaint(GoBangFlagPainter oldDelegate) => true;

}