import 'package:canvas_paint/ui/canvas/bezier/coordinate_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: 一阶贝塞尔
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class OneBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OneBezierPageState();
}

class _OneBezierPageState extends State<OneBezierPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomPaint(
          size: Size(ScreenUtil().screenWidth, 400.w),
          painter: CoordinatePainter(),
          foregroundPainter: OneBezierPainter(factor: _controller),
        ),
        Spacer(),
        TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              }
            },
            child: Text('启动动画', style: TextStyle(color: Colors.white),)
        ),
        Spacer(),
      ],
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

/// 一阶贝塞尔
class OneBezierPainter extends CustomPainter {
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
    ..color = Colors.blue;

  final Offset _p1 = Offset(-175, -150);
  final Offset _p2 = Offset(175, 150);

  OneBezierPainter({required this.factor}):super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    print('动画值 ${factor.value}');
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
    canvas.drawLine(_p1, _p2, _linePaint);
    // ui.canvas.drawCircle(_p1, 5, _pointPaint);
    // ui.canvas.drawCircle(_p2, 5, _pointPaint);
    canvas.drawCircle(Offset(_p1.dx + factor.value * (_p2.dx - _p1.dx), _p1.dy + factor.value * (_p2.dy - _p1.dy)), 5, _pointPaint);
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
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: 120));
    canvas.drawParagraph(paragraph, Offset(-halfW * 0.8, halfH * 0.8));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant OneBezierPainter oldDelegate) => this != oldDelegate;
}