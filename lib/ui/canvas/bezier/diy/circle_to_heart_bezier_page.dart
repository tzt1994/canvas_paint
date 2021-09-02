import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../coordinate_painter.dart';

/// Descriptions: 贝塞尔实现圆变心
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class CircleToHeartBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircleToHeartBezierPageState();
}

class _CircleToHeartBezierPageState extends State<CircleToHeartBezierPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
    // _animation = Tween(begin:0.0, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: CustomPaint(
          size: Size(ScreenUtil().screenWidth, double.infinity),
          painter: CoordinatePainter(),
          foregroundPainter: _CircleToHeartBezierPainter(factor: _controller),
        ),),
        SizedBox(height: 20.w,),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30.w))
            ),
            onPressed: () {
              if (_controller.status == AnimationStatus.dismissed) {
                _controller.forward();
              } else if (_controller.status == AnimationStatus.completed) {
                _controller.reset();
                _controller.forward();
              }
            },
            child: Text('启动动画', style: TextStyle(color: Colors.white),)),
        SizedBox(height: ScreenUtil().bottomBarHeight,),
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
class _CircleToHeartBezierPainter extends CustomPainter {
  /// 动画值
  final Animation<double> factor;
  final Paint _circleFillPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Colors.red.shade700;
  final Path _path = Path();

  final _coefficient = 0.18;

  double _r = 150;
  double _u = 85.25;
  late final _circleList = [
    Offset(-_r, 0), Offset(-_r, -_u), Offset(-_u, -_r), Offset(0, -_r), Offset(_u, -_r), Offset(_r, -_u),
    Offset(_r, 0), Offset(_r, _u), Offset(_u, _r), Offset(0, _r), Offset(-_u, _r), Offset(-_r, _u)
  ];

  late final _hearList = [
    Offset(-125, -25), Offset(-125, -80), Offset(-55, -100), Offset(0, -40), Offset(55, -100), Offset(125, -80),
    Offset(125, -25), Offset(125, 30), Offset(55, 100), Offset(0, 125), Offset(-55, 100), Offset(-125, 30)
  ];

  _CircleToHeartBezierPainter({required this.factor}):super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    print('动画值 ${factor.value}');
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
    _path.reset();
    final progress = pow(2, -10 * factor.value) * sin((factor.value - _coefficient / 4) * (2 * pi) / _coefficient) + 1;
    // final progress = factor.value;
    for(var i = 0; i < 4; i++) {
      if (i == 0) {
        _path.moveTo(_circleList[i].dx + progress * (_hearList[i].dx - _circleList[i].dx), _circleList[i].dy + progress * (_hearList[i].dy - _circleList[i].dy));
      }

      final endIndex = i == 3 ? 0 : i * 3 + 3;
      _path.cubicTo(
          _circleList[i * 3 + 1].dx + progress * (_hearList[i * 3 + 1].dx - _circleList[i * 3 + 1].dx),
          _circleList[i * 3 + 1].dy + progress * (_hearList[i * 3 + 1].dy - _circleList[i * 3 + 1].dy),
          _circleList[i * 3 + 2].dx + progress * (_hearList[i * 3 + 2].dx - _circleList[i * 3 + 2].dx),
          _circleList[i * 3 + 2].dy + progress * (_hearList[i * 3 + 2].dy - _circleList[i * 3 + 2].dy),
          _circleList[endIndex].dx + progress * (_hearList[endIndex].dx - _circleList[endIndex].dx),
          _circleList[endIndex].dy + progress * (_hearList[endIndex].dy - _circleList[endIndex].dy));
    }
    canvas.drawPath(_path, _circleFillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CircleToHeartBezierPainter oldDelegate) => this != oldDelegate;
}