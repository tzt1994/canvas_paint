import 'package:canvas_paint/ui/canvas/bezier/coordinate_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: 二阶贝塞尔
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class ThreeBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThreeBezierPageState();
}

class _ThreeBezierPageState extends State<ThreeBezierPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
          CustomPaint(
            size: Size(ScreenUtil().screenWidth, 400.w),
            painter: CoordinatePainter(),
            foregroundPainter: _ThreeBezierPainter(factor: _controller),
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
            child:  Text('三阶贝塞尔曲线\n'
                '由起点(A)，控制点(B)，控制点(C),终点(D)构成,上示例图展示了贝塞尔曲线点的绘制过程\n'
                'Path.moveTo(Offset c),指定起点\n'
                'Path.cubicTo(double x1, double y1, double x2, double y2, double x3, double y3)\n'
                'x1,y1控制点, x2,y2控制点，x3,y3终点\n'
                'ui.canvas.drawPath(Path, Paint)绘制path', style: TextStyle(fontSize: 14.sp, color: Colors.black, wordSpacing: 1.0), textAlign: TextAlign.start),
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
class _ThreeBezierPainter extends CustomPainter {
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
  final Offset _p1 = Offset(-175, 100);
  final Offset _p2 = Offset(175, 100);
  final Offset _c1 = Offset(-175, -175);
  final Offset _c2 = Offset(175, -175);

  _ThreeBezierPainter({required this.factor}):super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    print('动画值 ${factor.value}');
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
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
    canvas.drawParagraph(paragraphA, Offset(_p1.dx, _p1.dy + 10));
    /// 绘制B点(控制点)
    canvas.drawCircle(_c1, 5, _pointPaint);
    ui.ParagraphBuilder pbB = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbB.pushStyle(ui.TextStyle(color: Colors.blue));
    pbB.addText('B');
    ui.Paragraph paragraphB = pbB.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphB, Offset(_c1.dx - 20, _c1.dy - 20));
    /// 绘制C点(控制点2)
    canvas.drawCircle(_c2, 5, _pointPaint);
    ui.ParagraphBuilder pbC = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbC.pushStyle(ui.TextStyle(color: Colors.blue));
    pbC.addText('C');
    ui.Paragraph paragraphC = pbC.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphC, Offset(_c2.dx + 5, _c2.dy - 20));
    /// 绘制D点(控制点2)
    canvas.drawCircle(_p2, 5, _pointPaint);
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
    canvas.drawParagraph(paragraphD, Offset(_p2.dx, _p2.dy + 10));
    /// 绘制连线
    _linePaint.color = Colors.blue;
    canvas.drawLine(_p1, _c1, _linePaint);
    canvas.drawLine(_c1, _c2, _linePaint);
    canvas.drawLine(_c2, _p2, _linePaint);
    /// 绘制三阶贝赛尔
    _linePaint.color = Colors.red;
    _path.moveTo(_p1.dx, _p1.dy);
    _path.cubicTo(_c1.dx, _c1.dy, _c2.dx, _c2.dy, _p2.dx, _p2.dy);
    canvas.drawPath(_path, _linePaint);
    /// E点(在控制线AB上的变化点) F点(在控制线BC线上的变化点), G点(在控制线BC线上的变化点),H点(在变化线EF上的变化点), I点(在变化线FG上的变化点),J点(曲线上的店)
    final Offset _e = Offset(_p1.dx + factor.value * (_c1.dx - _p1.dx), _p1.dy +factor.value * (_c1.dy - _p1.dy));
    final Offset _f = Offset(_c1.dx + factor.value * (_c2.dx - _c1.dx), _c1.dy +factor.value * (_c2.dy - _c1.dy));
    final Offset _g = Offset(_c2.dx + factor.value * (_p2.dx - _c2.dx), _c2.dy + factor.value * (_p2.dy - _c2.dy));
    final Offset _h = Offset(_e.dx + factor.value * (_f.dx - _e.dx), _e.dy + factor.value * (_f.dy - _e.dy));
    final Offset _i = Offset(_f.dx + factor.value * (_g.dx - _f.dx), _f.dy + factor.value * (_g.dy - _f.dy));
    final Offset _j = Offset(_h.dx + factor.value * (_i.dx - _h.dx), _h.dy + factor.value * (_i.dy - _h.dy));
    /// 绘制变化中的控制线
    _linePaint.color = Colors.yellowAccent;
    canvas.drawLine(_e, _f, _linePaint);
    canvas.drawLine(_f, _g, _linePaint);
    _pointPaint.color = Colors.yellowAccent;
    /// 绘制E点, 控制线在AB线段的变化
    canvas.drawCircle(_e, 5, _pointPaint);
    ui.ParagraphBuilder pbE = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbE.pushStyle(ui.TextStyle(color: Colors.yellow.shade900));
    pbE.addText('E');
    ui.Paragraph paragraphE = pbE.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphE, Offset(_e.dx - 20, _e.dy));
    ///  绘制F点, 控制线在BC线段的变化
    canvas.drawCircle(_f, 5, _pointPaint);
    ui.ParagraphBuilder pbF = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbF.pushStyle(ui.TextStyle(color: Colors.yellow.shade900));
    pbF.addText('F');
    ui.Paragraph paragraphF = pbF.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphF, Offset(_f.dx + 5, _f.dy - 30));
    /// 绘制G点,控制线在CD线段的变化
    canvas.drawCircle(_g, 5, _pointPaint);
    ui.ParagraphBuilder pbG = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbG.pushStyle(ui.TextStyle(color: Colors.yellow.shade900));
    pbG.addText('G');
    ui.Paragraph paragraphG = pbG.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphG, Offset(_g.dx + 5, _g.dy + 10));
    /// 绘制变化中的控制线
    _linePaint.color = Colors.green;
    canvas.drawLine(_h, _i, _linePaint);
    _pointPaint.color = Colors.green;
    /// 绘制H点,控制线在EF线段的变化
    canvas.drawCircle(_h, 5, _pointPaint);
    ui.ParagraphBuilder pbH = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbH.pushStyle(ui.TextStyle(color: Colors.green));
    pbH.addText('H');
    ui.Paragraph paragraphH = pbH.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphH, Offset(_h.dx, _h.dy + 5));
    /// 绘制I点,控制线在FG线段的变化
    canvas.drawCircle(_i, 5, _pointPaint);
    ui.ParagraphBuilder pbI = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbI.pushStyle(ui.TextStyle(color: Colors.green));
    pbI.addText('I');
    ui.Paragraph paragraphI = pbI.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphI, Offset(_i.dx + 5, _i.dy + 5));
    /// 绘制贝塞尔曲线的点
    _pointPaint.color = Colors.red;
    canvas.drawCircle(_j, 5, _pointPaint);
    ui.ParagraphBuilder pbJ = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pbJ.pushStyle(ui.TextStyle(color: Colors.red));
    pbJ.addText('J');
    ui.Paragraph paragraphJ = pbJ.build()..layout(ui.ParagraphConstraints(width: 30));
    canvas.drawParagraph(paragraphJ, Offset(_j.dx + 5, _j.dy + 5));
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
  bool shouldRepaint(covariant _ThreeBezierPainter oldDelegate) => this != oldDelegate;
}