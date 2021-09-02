import 'package:canvas_paint/common/utils/image_utils.dart';
import 'package:canvas_paint/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'package:canvas_paint/common/utils/cp_extensions.dart';

/// Descriptions: matrix4几何变换
/// User: tangzhentao
/// Date: 4:10 下午 2021/8/31
///

class Matrix4Page extends StatefulWidget {
  Matrix4Page({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Matrix4PageState();
}

class _Matrix4PageState extends State<Matrix4Page> with AutomaticKeepAliveClientMixin {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    ImageUtils.getImageByAsset(context, Res.maps).then((value) {
      setState(() {
        _image = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, ScreenUtil().bottomBarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Matrix4(三维变换矩阵)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('1.创建Matrix4对象),例如Matrix.identity();\n'
              '2.设置Matrix4的变换属性,例如Matrix.translate(dynamic x, [double y = 0.0, double z = 0.0])\n'
              '3.将Matrix4应用到canvas, canvas.transform(Float64List matrix4)', style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 20.w,),
          Text('平移,', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('translate(dynamic x, [double y=0.0,double z=0.0])\n'
              '下图左边是原位置，右图是平移size.width / 2的位置', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image),
          ),
          SizedBox(height: 20.w,),
          Text('旋转 \ncanvas.rotate(double radians)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('radians:旋转角度的弧度值，正值顺时针，负值逆时针\n'
              '旋转的中心点默认是左上角(0,0)原点，可以通过canvas.translate()改变中心点\n'
              '下图表示是120度的效果', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image, transformType: TransformType.rotate),
          ),
          SizedBox(height: 20.w,),
          Text('缩放 \ncanvas. scale(double sx, [double? sy])', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('sx,sy:水平和竖直方向的缩放只\n'
              'sy未指定的话，sx将用于水平和竖直两个方向\n'
              '缩放的中心点默认是左上角(0,0)原点，可以通过canvas.translate()改变中心点\n'
              '下图是缩放为0.5的效果', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image, transformType: TransformType.scale),
          ),
          SizedBox(height: 20.w,),
          Text('错切 \ncanvas.skew(double sx, double sy)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('sx,sy:沿顺指针方向在运行单位上水平或竖直偏斜\n'
              '下图为sx,sy为0.3的效果', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image, transformType: TransformType.skew),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Matrix4Painter extends CustomPainter {
  final Paint _layerPaint = Paint()..isAntiAlias = true;

  final Paint _linePaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final TransformType transformType;
  final ui.Image? image;

  _Matrix4Painter({this.transformType = TransformType.translate, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
    canvas.drawColor(Colors.blue, BlendMode.color);
    canvas.restore();
    if (image != null) {
      switch (transformType) {
        case TransformType.translate:
          final rect = Rect.fromLTRB(30, 10, size.height + 10, size.height - 10);
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          /// 平移画布
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          final Matrix4 matrix4 = Matrix4.identity();
          matrix4.translate(size.width / 2, 0, 100);
          canvas.transform(matrix4.storage);
          canvas.drawImageRect(
              image!,
              Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()),
              rect, _layerPaint);
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          canvas.restore();
          break;
        case TransformType.rotate:
          final rect = Rect.fromLTRB(30, 10, size.height + 10, size.height - 10);
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          /// 旋转画布
          final rect2 = rect.translate(size.width / 2, 0);
          final rect3 = Rect.fromCenter(center: Offset(0, 0), width: rect.width, height: rect.height);
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          canvas.translate(rect2.center.dx, rect2.center.dy);
          final Matrix4 matrix4 = Matrix4.identity();
          matrix4.rotateX(120.toRadian);
          matrix4.rotateY(120.toRadian);
          matrix4.rotateZ(120.toRadian);
          canvas.transform(matrix4.storage);
          canvas.drawImageRect(
              image!,
              Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()),
              rect3, _layerPaint);
          _linePaint.color = Colors.red;
          canvas.drawRect(rect3, _linePaint);
          canvas.restore();
          break;
        case TransformType.scale:
          final rect = Rect.fromLTRB(30, 10, size.height + 10, size.height - 10);
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          /// 缩放画布
          final rect2 = rect.translate(size.width / 2, 0);
          final rect3 = Rect.fromCenter(center: Offset(0, 0), width: rect.width, height: rect.height);
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          canvas.translate(rect2.center.dx, rect2.center.dy);
          canvas.scale(0.5);
          canvas.drawImageRect(
              image!,
              Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()),
              rect3, _layerPaint);
          _linePaint.color = Colors.red;
          canvas.drawRect(rect3, _linePaint);
          canvas.restore();
          break;
        case TransformType.skew:
          final rect = Rect.fromLTRB(30, 10, size.height + 10, size.height - 10);
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          /// 错切画布
          final rect2 = rect.translate(size.width / 2, 0);
          final rect3 = Rect.fromCenter(center: Offset(0, 0), width: rect.width, height: rect.height);
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          canvas.translate(rect2.center.dx, rect2.center.dy);
          canvas.skew(0.3, 0.3);
          canvas.drawImageRect(
              image!,
              Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()),
              rect3, _layerPaint);
          _linePaint.color = Colors.red;
          canvas.drawRect(rect3, _linePaint);
          canvas.restore();

          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => this != oldDelegate;

}

enum TransformType {
  translate, rotate, scale, skew
}
