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
          Text('平移 \ntranslate(dynamic x, [double y=0.0,double z=0.0])', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('通过Vector3,Vector4或x,y,z转换此矩阵\n'
              '下图左边是原位置，右图是平移size.width / 2的位置', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image),
          ),
          SizedBox(height: 20.w,),
          Text('旋转 \ncanvas.rotateXXX()', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('rotate系列方法旋转画布\n'
              '下图表示是x,y,z轴各旋转120度的效果', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image, transformType: TransformType.rotate),
          ),
          SizedBox(height: 20.w,),
          Text('缩放 \ncanvas.scale(dynamic x, [double? y, double? z])', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('通过 [Vector3]、[Vector4] 或 x,y,z 缩放此矩阵\n'
              '下图是缩放为0.7的效果', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _Matrix4Painter(image: _image, transformType: TransformType.scale),
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
          final Matrix4 matrix4 = Matrix4.identity();
          matrix4.translate(rect2.center.dx, rect2.center.dy);
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
          final Matrix4 matrix4 = Matrix4.identity();
          matrix4.translate(rect2.center.dx, rect2.center.dy);
          matrix4.scale(0.7, 0.7, 0.5);
          canvas.transform(matrix4.storage);
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
  translate, rotate, scale
}
