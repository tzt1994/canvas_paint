import 'package:canvas_paint/ui/canvas/bezier/coordinate_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Descriptions: 贝塞尔实现圆
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class CircleBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircleBezierPageState();
}

class _CircleBezierPageState extends State<CircleBezierPage> with AutomaticKeepAliveClientMixin {
  late final ValueNotifier<double> _controller;

  @override
  void initState() {
    _controller = ValueNotifier<double>(0.55);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(child: CustomPaint(
          size: Size(ScreenUtil().screenWidth, double.infinity),
          painter: CoordinatePainter(),
          foregroundPainter: _CircleBezierPainter(factor: _controller),
        ),),
        ValueListenableBuilder<double>(
            valueListenable: _controller,
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20.w, left: 20.w),
                  child: Text('控制点比例$value', style: TextStyle(fontSize: 14.sp, color: Colors.black),),
                ),
                Slider(
                  value: value,
                  onChanged: (value) => _controller.value = value,
                ),
                SizedBox(height: ScreenUtil().bottomBarHeight,)
              ],
            )
        ),
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
class _CircleBezierPainter extends CustomPainter {
  /// 动画值
  final ValueNotifier<double> factor;

  final Paint _linePaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..color = Colors.red
    ..strokeWidth = 2;
  final Paint _circleFillPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Colors.blue;
  final Path _path = Path();

  final double radius = 150;

  late final Offset _left;
  late final Offset _top;
  late final Offset _right;
  late final Offset _bottom;

  _CircleBezierPainter({required this.factor}):super(repaint: factor) {
    _left = Offset(-radius, 0);
    _top = Offset(0, -radius);
    _right = Offset(radius, 0);
    _bottom = Offset(0, radius);
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('动画值 ${factor.value}');
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
    /// 计算控制点
    final leftC1 = Offset(-radius, factor.value * -radius);
    final leftC2 = Offset(factor.value * -radius, -radius);
    final topC1 = Offset(radius * factor.value, -radius);
    final topC2 = Offset(radius, factor.value * -radius);
    final rightC1 = Offset(radius, factor.value * radius);
    final rightC2 = Offset(radius * factor.value, radius);
    final bottomC1 = Offset(-radius * factor.value, radius);
    final bottomC2 = Offset(-radius, radius * factor.value);
    _path.reset();
    _path.moveTo(_left.dx, _left.dy);
    _path.cubicTo(leftC1.dx, leftC1.dy, leftC2.dx, leftC2.dy, _top.dx, _top.dy);
    _path.cubicTo(topC1.dx, topC1.dy, topC2.dx, topC2.dy, _right.dx, _right.dy);
    _path.cubicTo(rightC1.dx, rightC1.dy, rightC2.dx, rightC2.dy, _bottom.dx, _bottom.dy);
    _path.cubicTo(bottomC1.dx, bottomC1.dy, bottomC2.dx, bottomC2.dy, _left.dx, _left.dy);
    canvas.drawPath(_path, _circleFillPaint);
    _linePaint.color = Colors.red;
    canvas.drawCircle(Offset(0, 0), radius, _linePaint);
    /// 绘制控制线 左上段
    _path.reset();
    _path.moveTo(_left.dx, _left.dy);
    _path.lineTo(leftC1.dx, leftC1.dy);
    _path.lineTo(leftC2.dx, leftC2.dy);
    _path.lineTo(_top.dx, _top.dy);
    _linePaint.color = Colors.pink.shade300;
    canvas.drawPath(_path, _linePaint);
    /// 绘制控制线 右上段
    _path.reset();
    _path.moveTo(_top.dx, _top.dy);
    _path.lineTo(topC1.dx, topC1.dy);
    _path.lineTo(topC2.dx, topC2.dy);
    _path.lineTo(_right.dx, _right.dy);
    _linePaint.color = Colors.yellow.shade300;
    canvas.drawPath(_path, _linePaint);
    /// 绘制控制线 右下段
    _path.reset();
    _path.moveTo(_right.dx, _right.dy);
    _path.lineTo(rightC1.dx, rightC1.dy);
    _path.lineTo(rightC2.dx, rightC2.dy);
    _path.lineTo(_bottom.dx, _bottom.dy);
    _linePaint.color = Colors.green.shade300;
    canvas.drawPath(_path, _linePaint);
    /// 绘制控制线 左下段
    _path.reset();
    _path.moveTo(_bottom.dx, _bottom.dy);
    _path.lineTo(bottomC1.dx, bottomC1.dy);
    _path.lineTo(bottomC2.dx, bottomC2.dy);
    _path.lineTo(_left.dx, _left.dy);
    _linePaint.color = Colors.amber.shade600;
    canvas.drawPath(_path, _linePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CircleBezierPainter oldDelegate) => this != oldDelegate;
}