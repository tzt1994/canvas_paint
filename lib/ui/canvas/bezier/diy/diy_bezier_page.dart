import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../coordinate_painter.dart';
import 'diy_bezier_controller.dart';

/// Descriptions: 贝塞尔diy
/// User: tangzhentao
/// Date: 11:14 上午 2021/8/25
///

class DiyBezierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiyBezierPageState();
}

class _DiyBezierPageState extends State<DiyBezierPage> with AutomaticKeepAliveClientMixin {
  late final DiyBezierController _controller;

  final GlobalKey _key = GlobalKey();

  Size? _size;

  @override
  void initState() {
    _controller = DiyBezierController();
    super.initState();
  }

  Offset _lastPosition = Offset(0, 0);

  /// 处理按下事件
  void _handlePanDown(DragDownDetails dragDown) {
    _lastPosition = dragDown.localPosition;
    if (_size == null) {
      _size = _key.currentContext?.size;
    }
    if (_size != null) {
      print('原位置 ${dragDown.localPosition}');
      final location = dragDown.localPosition.translate(-_size!.width / 2, -_size!.height / 2);
      print('按下 $location}');
      _controller.calculateScrollTypeAndLinePointState(location);
    }
  }

  /// 处理平移事件
  void _handlePanUpdate(DragUpdateDetails dragUpdate) {
    final position = dragUpdate.localPosition;
    print('平移偏移量  ${position.dx} - ${position.dy}');
    _controller.panUpdate(Offset(_lastPosition.dx - position.dx, _lastPosition.dy - position.dy));
    _lastPosition = position;
  }

  /// 处理结束事件
  void _handlePanEnd(DragEndDetails? dragEnd) {
    print('结束  ${dragEnd?.velocity.pixelsPerSecond}');
    _controller.panEnd();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            // onPointerDown: (down) {},
            // onPointerMove: (move) {},
            // onPointerUp: (up) {},
            // onPointerCancel: (cancel) {},
            onPanStart: (start) {},
            onPanDown: _handlePanDown,
            onPanUpdate: _handlePanUpdate,
            onPanEnd: _handlePanEnd,
            onPanCancel: () => _handlePanEnd(null),
            child: CustomPaint(
              key: _key,
              size: Size(ScreenUtil().screenWidth, double.infinity),
              painter: CoordinatePainter(),
              foregroundPainter: _DiyBezierPainter(controller: _controller),
            ),
          ),
        ),
        ChangeNotifierProvider<DiyBezierController>(
          create: (_) => _controller,
          child: Consumer<DiyBezierController>(
            builder: (context, diy, child) => Container(
              decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1.w))),
              padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, ScreenUtil().bottomBarHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text('拽动状态', style: TextStyle(fontSize: 14.sp, color: Colors.black),),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Radio(value: DragType.free, groupValue: diy.dragType, onChanged: (value) => diy.dragType = (value as DragType), activeColor: Colors.pinkAccent,),
                      Text('自由', style: TextStyle(fontSize: 12.sp, color: Colors.black),),
                      Spacer(),
                      Radio(value: DragType.three, groupValue: diy.dragType, onChanged: (value) => diy.dragType = (value as DragType), activeColor: Colors.pinkAccent),
                      Text('三点拽动', style: TextStyle(fontSize: 12.sp, color: Colors.black),),
                      Spacer(),
                      Radio(value: DragType.mirror_same_direction, groupValue: diy.dragType, onChanged: (value) => diy.dragType = (value as DragType), activeColor: Colors.pinkAccent),
                      Text('镜像同向', style: TextStyle(fontSize: 12.sp, color: Colors.black),),
                      Spacer(),
                      Radio(value: DragType.mirror_diff_direction, groupValue: diy.dragType, onChanged: (value) => diy.dragType = (value as DragType), activeColor: Colors.pinkAccent),
                      Text('镜像异常', style: TextStyle(fontSize: 12.sp, color: Colors.black),),
                      Spacer(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: _controller.reset,
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),
                            child: Text('复位', style: TextStyle(fontSize: 14.sp, color: Colors.white),)
                        ),
                      ),
                      SizedBox(width: 15.w,),
                      Expanded(
                        child: TextButton(
                            onPressed: _controller.printPoint,
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),
                            child: Text('打印控制点', style: TextStyle(fontSize: 14.sp, color: Colors.white),)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('是否显示辅助线', style: TextStyle(fontSize: 14.sp, color: Colors.black),),
                      Switch(value: diy.showAssistLine, onChanged: (value) => diy.showAssistLine = value, activeColor: Colors.pinkAccent,)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 一阶贝塞尔
class _DiyBezierPainter extends CustomPainter {
  /// 动画值
  final DiyBezierController controller;

  final Paint _linePaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..color = Colors.green.shade700
    ..strokeWidth = 2;
  final Paint _circleFillPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Colors.blue;
  final Path _path = Path();

  _DiyBezierPainter({required this.controller}):super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    canvas.save();
    canvas.translate(halfW, halfH);
    _circleFillPaint.color = Colors.green.shade700;
    _path.reset();
    _path.moveTo(controller.left.dx, controller.left.dy);
    _path.cubicTo(controller.leftTop.dx, controller.leftTop.dy, controller.topLeft.dx, controller.topLeft.dy, controller.top.dx, controller.top.dy);
    _path.cubicTo(controller.topRight.dx, controller.topRight.dy, controller.rightTop.dx, controller.rightTop.dy, controller.right.dx, controller.right.dy);
    _path.cubicTo(controller.rightBottom.dx, controller.rightBottom.dy, controller.bottomRight.dx, controller.bottomRight.dy, controller.bottom.dx, controller.bottom.dy);
    _path.cubicTo(controller.bottomLeft.dx, controller.bottomLeft.dy, controller.leftBottom.dx, controller.leftBottom.dy, controller.left.dx, controller.left.dy);
    canvas.drawPath(_path, _circleFillPaint);
    /// 绘制辅助线
    if (controller.showAssistLine) {
      _linePaint.color = Colors.amber;
      canvas.drawCircle(Offset(0, 0), controller.radius, _linePaint);
      /// 绘制线
      /// 绘制左边线
      _linePaint.color = controller.isLeftLine ? Colors.blue : Colors.pinkAccent;
      canvas.drawLine(controller.left, controller.leftTop, _linePaint);
      canvas.drawLine(controller.left, controller.leftBottom, _linePaint);
      /// 绘制上边线
      _linePaint.color = controller.isTopLine ? Colors.blue : Colors.pinkAccent;
      canvas.drawLine(controller.top, controller.topLeft, _linePaint);
      canvas.drawLine(controller.top, controller.topRight, _linePaint);
      /// 绘制右边线
      _linePaint.color = controller.isRightLine ? Colors.blue : Colors.pinkAccent;
      canvas.drawLine(controller.right, controller.rightTop, _linePaint);
      canvas.drawLine(controller.right, controller.rightBottom, _linePaint);
      /// 绘制下边线
      _linePaint.color = controller.isBottomLine ? Colors.blue : Colors.pinkAccent;
      canvas.drawLine(controller.bottom, controller.bottomRight, _linePaint);
      canvas.drawLine(controller.bottom, controller.bottomLeft, _linePaint);

      /// 绘制点
      /// 绘制左边控制点
      _circleFillPaint.color = controller.isLeftPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.left, (controller.isLeftPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制左边1控制点
      _circleFillPaint.color = controller.isLeftTopPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.leftTop, (controller.isLeftTopPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制左边2控制点
      _circleFillPaint.color = controller.isTopLeftPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.topLeft, (controller.isTopLeftPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制上边控制点
      _circleFillPaint.color = controller.isTopPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.top, (controller.isTopPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制上边1控制点
      _circleFillPaint.color = controller.isTopRightPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.topRight, (controller.isTopRightPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制上边2控制点
      _circleFillPaint.color = controller.isRightTopPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.rightTop, (controller.isRightTopPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制右边控制点
      _circleFillPaint.color = controller.isRightPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.right, (controller.isRightPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制右边1控制点
      _circleFillPaint.color = controller.isRightBottomPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.rightBottom, (controller.isRightBottomPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制右边2控制点
      _circleFillPaint.color = controller.isBottomRightPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.bottomRight, (controller.isBottomRightPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制下边控制点
      _circleFillPaint.color = controller.isBottomPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.bottom, (controller.isBottomPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制下边1控制点
      _circleFillPaint.color = controller.isBottomLeftPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.bottomLeft, (controller.isBottomLeftPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
      /// 绘制下边2控制点
      _circleFillPaint.color = controller.isLeftBottomPoint ? Colors.blue : Colors.pinkAccent;
      canvas.drawCircle(controller.leftBottom, (controller.isLeftBottomPoint ? 1.5 : 1) * controller.pointRadius, _circleFillPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DiyBezierPainter oldDelegate) => this != oldDelegate;
}