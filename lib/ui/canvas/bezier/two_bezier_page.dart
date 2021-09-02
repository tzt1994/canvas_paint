import 'package:canvas_paint/ui/canvas/bezier/coordinate_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: 二阶贝塞尔
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class TwoBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TwoBezierPageState();
}

class _TwoBezierPageState extends State<TwoBezierPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
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
          SizedBox(
            height: 400.w,
            child: CustomPaint(
              size: Size(ScreenUtil().screenWidth, 400.w),
              painter: CoordinatePainter(),
              foregroundPainter: _TwoBezierPainter(factor: _controller),
            ),
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
            child:  Text('二阶贝塞尔曲线\n'
                '由起点(A)，控制点(B)，终点(C)构成,上示例图展示了贝塞尔曲线点的绘制过程\n'
                'Path.moveTo(Offset c),指定起点\n'
                'Path.quadraticBezierTo(double x1, double y1, double x2, double y2)\n'
                'x1,y1控制点, x2,y2终点坐标\n'
                'ui.canvas.drawPath(Path, Paint)绘制path', style: TextStyle(fontSize: 14.sp, color: Colors.black), textAlign: TextAlign.start,),
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
class _TwoBezierPainter extends CustomPainter {
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
  final Offset _p1 = Offset(-175, 50);
  final Offset _p2 = Offset(175, 50);
  final Offset _controllerPoint = Offset(0, -175);

  _TwoBezierPainter({required this.factor}):super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    print('动画值 ${factor.value}');
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
    /// 绘制二阶贝赛尔
    _linePaint.color = Colors.red;
    _path.moveTo(_p1.dx, _p1.dy);
    _path.quadraticBezierTo(_controllerPoint.dx, _controllerPoint.dy, _p2.dx, _p2.dy);
    canvas.drawPath(_path, _linePaint);
    /// 绘制A点(起点)
    _pointPaint.color = Colors.blue;
    canvas.drawCircle(_p1, 5, _pointPaint);
    ui.ParagraphBuilder pbA = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbA.pushStyle(ui.TextStyle(color: Colors.red));
    pbA.addText('A');
    ui.Paragraph paragraphA = pbA.build()..layout(ui.ParagraphConstraints(width: 120));
    canvas.drawParagraph(paragraphA, Offset(_p1.dx + 5, _p1.dy + 10));
    /// 绘制B点(控制点)
    canvas.drawCircle(_controllerPoint, 5, _pointPaint);
    ui.ParagraphBuilder pbB = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbB.pushStyle(ui.TextStyle(color: Colors.red));
    pbB.addText('B');
    ui.Paragraph paragraphB = pbB.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphB, Offset(_controllerPoint.dx - 30, _controllerPoint.dy - 20));
    /// 绘制C点(终点)
    canvas.drawCircle(_p2, 5, _pointPaint);
    ui.ParagraphBuilder pbC = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbC.pushStyle(ui.TextStyle(color: Colors.red));
    pbC.addText('C');
    ui.Paragraph paragraphC = pbC.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphC, Offset(_p2.dx + 5, _p2.dy + 10));
    /// 绘制连线
    _linePaint.color = Colors.blue;
    canvas.drawLine(_p1, _controllerPoint, _linePaint);
    canvas.drawLine(_controllerPoint, _p2, _linePaint);
    _linePaint.color = Colors.yellowAccent;
    /// D点(在控制线AB上的变化点) E点(在控制线BC线上的变化点), F点(贝赛尔曲线的点)
    final Offset _d = Offset(_p1.dx + factor.value * (_controllerPoint.dx - _p1.dx), _p1.dy +factor.value * (_controllerPoint.dy - _p1.dy));
    final Offset _e = Offset(_controllerPoint.dx + factor.value * (_p2.dx - _controllerPoint.dx), _controllerPoint.dy +factor.value * (_p2.dy - _controllerPoint.dy));
    final Offset _f = Offset(_d.dx + factor.value * (_e.dx - _d.dx), _d.dy + factor.value * (_e.dy - _d.dy));
    /// 绘制变化中的控制线
    canvas.drawLine(_d, _e, _linePaint);
    _pointPaint.color = Colors.yellowAccent;
    /// 绘制D点
    canvas.drawCircle(_d, 5, _pointPaint);
    /// 绘制D点, 控制线在AB线段的变化
    ui.ParagraphBuilder pbD = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbD.pushStyle(ui.TextStyle(color: Colors.red));
    pbD.addText('D');
    ui.Paragraph paragraphD = pbD.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphD, Offset(_d.dx + 5, _d.dy - 30));
    /// 绘制E点
    canvas.drawCircle(_e, 5, _pointPaint);
    /// 绘制E点, 控制线在BC线段的变化
    ui.ParagraphBuilder pbE = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbE.pushStyle(ui.TextStyle(color: Colors.red));
    pbE.addText('E');
    ui.Paragraph paragraphE = pbE.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphE, Offset(_e.dx + 5, _e.dy - 30));
    /// 绘制F点,贝赛尔曲线经过的点
    _pointPaint.color = Colors.red;
    canvas.drawCircle(_f, 5, _pointPaint);
    ui.ParagraphBuilder pbF = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbF.pushStyle(ui.TextStyle(color: Colors.red));
    pbF.addText('F');
    ui.Paragraph paragraphF = pbF.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphF, Offset(_f.dx + 5, _f.dy + 10));
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
  bool shouldRepaint(covariant _TwoBezierPainter oldDelegate) => this != oldDelegate;
}