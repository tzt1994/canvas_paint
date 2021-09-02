import 'package:canvas_paint/ui/canvas/bezier/bezier_utils.dart';
import 'package:canvas_paint/ui/canvas/bezier/coordinate_painter.dart';
import 'package:canvas_paint/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: n阶贝塞尔
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class MultiBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultiBezierPageState();
}

class _MultiBezierPageState extends State<MultiBezierPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 7));
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPaint(
            size: Size(ScreenUtil().screenWidth, 400.w),
            painter: CoordinatePainter(),
            foregroundPainter: _MultiBezierPainter(factor: _controller),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
            child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                  }
                },
                child: Text('启动动画', style: TextStyle(color: Colors.white),)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
            child:  Text('n阶贝塞尔曲线\n'
                '多阶贝塞尔曲线通过降阶为一个一个的二阶贝塞尔来绘制\n'
                '公式为:', style: TextStyle(fontSize: 14.sp, color: Colors.black), textAlign: TextAlign.start,),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w, left: 15.w),
            child:  Image.asset(Res.bezier),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

/// 二阶贝塞尔
class _MultiBezierPainter extends CustomPainter {
  /// 动画值
  final Animation<double> factor;

  final Paint _linePaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..color = Colors.red
    ..strokeWidth = 5;
  final Paint _pointPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Colors.blue.shade800;

  final Path _path = Path();

  final List<Color> _colors = [
    Colors.yellow, Colors.green, Color(0xFF4B0082),  Color(0xFF800000),
    Color(0xFFFFC0CB), Color(0xFFFFA500), // Color(0xFF4B0082), Color(0xFF4B0082)
  ];

  final List<Offset> _controllerList = [
    Offset(-75, 125), Offset(-175, 35), Offset(-170, -100), Offset(-40, -55),
    Offset(0, -200), Offset(175, -100), Offset(150, 65), Offset(50, 225),
  ];

  _MultiBezierPainter({required this.factor}):super(repaint: factor) {
    /// 填充path
    final list = BezierUtils().buildBezier(_controllerList, frame: 120);
    _path.moveTo(list[0].dx, list[0].dy);
    list.sublist(1, list.length).forEach((p) => _path.lineTo(p.dx, p.dy));
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('动画值 ${factor.value}');
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
    /// 绘制连线和点
    _pointPaint.color = Colors.blue;
    _linePaint..color = Colors.blue
      ..strokeWidth = 5;
    var last = _controllerList[0];
    canvas.drawCircle(last, 5, _pointPaint);
    _controllerList.sublist(1, _controllerList.length).forEach((p) {
      canvas.drawCircle(p, 5, _pointPaint);
      canvas.drawLine(last, p, _linePaint);
      last = p;
    });
    /// 绘制贝赛尔
    _linePaint.color = Colors.red;
    canvas.drawPath(_path, _linePaint);
    /// 绘制控制线
    if (factor.value < 1 && factor.value > 0) {
      _linePaint.strokeWidth = 2;
      final allLowControllerList = BezierUtils().calculateAllLowPoints(factor.value, _controllerList);
      Offset? pb;
      for (var points in allLowControllerList) {
        final index = allLowControllerList.indexOf(points);
        _linePaint.color = _colors[index % 6];
        _pointPaint.color = _colors[index % 6];
        if (points.length == 2) {
          /// 一阶直线
          final p1 = points[0];
          final p2 = points[1];
          pb = Offset((1 - factor.value) * p1.dx + factor.value * p2.dx, (1 - factor.value) * p1.dy + factor.value * p2.dy);
          canvas.drawCircle(p1, 5, _pointPaint);
          canvas.drawCircle(p2, 5, _pointPaint);
          canvas.drawLine(p1, p2, _linePaint);
        } else {
          var p1 = points[0];
          canvas.drawCircle(p1, 5, _pointPaint);
          points.sublist(1, points.length).forEach((p2) {
            canvas.drawCircle(p2, 5, _pointPaint);
            canvas.drawLine(p1, p2, _linePaint);
            p1 = p2;
          });
        }
      }
      if (pb != null) {
        _pointPaint.color = Colors.red;
        canvas.drawCircle(pb, 5, _pointPaint);
      }
    }
    /// 绘制进度变化
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pb.pushStyle(ui.TextStyle(color: Colors.black));
    pb.addText('u = ${factor.value}');
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: 180));
    canvas.drawParagraph(paragraph, Offset(-halfW * 0.8, halfH * 0.8));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MultiBezierPainter oldDelegate) => this != oldDelegate;


}