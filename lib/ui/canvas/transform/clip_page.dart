import 'package:canvas_paint/common/utils/image_utils.dart';
import 'package:canvas_paint/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: canvas裁剪
/// User: tangzhentao
/// Date: 4:10 下午 2021/8/31
///

class ClipPage extends StatefulWidget {
  ClipPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClipPageState();
}

class _ClipPageState extends State<ClipPage> with AutomaticKeepAliveClientMixin {
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
          Text('矩形裁剪', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('canvas.clipRect(Rect rect, { ClipOp clipOp = ClipOp.intersect, bool doAntiAlias = true }\n'
              'rect:裁剪的矩形范围\n'
              'clipOp: ui.ClipOp,选择裁剪范围相交和不同\n'
              'doAntiAlias:true时启动抗锯齿', style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 5.w,),
          Row(
            children: [
              Expanded(child: Text('${ui.ClipOp.intersect}', textAlign: TextAlign.center,)),
              Expanded(child: Text('${ui.ClipOp.difference}', textAlign: TextAlign.center)),
            ],
          ),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _ClipPainter(image: _image),
          ),
          SizedBox(height: 20.w,),
          Text('圆角裁剪', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('canvas.clipRRect(RRect rrect, {bool doAntiAlias = true})\n'
              'rect:裁剪的矩形范围\n'
              'doAntiAlias:true时启动抗锯齿\n'
              '白线为完整图片位置，红线为裁剪圆角矩形', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _ClipPainter(image: _image, clipType: ClipType.rRect),
          ),
          SizedBox(height: 20.w,),
          Text('路径裁剪', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('canvas.clipPath(Path path, {bool doAntiAlias = true }\n'
              'rect:裁剪的矩形范围\n'
              'doAntiAlias:true时启动抗锯齿\n'
              '白线为完整图片位置，红线为裁剪路径', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 120.w),
            painter: _ClipPainter(image: _image, clipType: ClipType.path),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ClipPainter extends CustomPainter {
  final Paint _layerPaint = Paint()..isAntiAlias = true;

  final Paint _linePaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final Path _path = Path();

  final ClipType clipType;
  final ui.Image? image;

  _ClipPainter({this.clipType = ClipType.rect, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
    canvas.drawColor(Colors.blue, BlendMode.color);
    canvas.restore();
    if (image != null) {
      switch (clipType) {
        case ClipType.rect:
          final rect = Rect.fromLTRB(30, 10, size.height + 10, size.height - 10);
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          canvas.clipRect(Rect.fromCenter(center: rect.center, width: rect.width / 2, height: rect.width / 2));
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          canvas.restore();
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          final rect2 = Rect.fromLTRB(10 + size.width / 2, 10, size.height - 10 + size.width / 2, size.height - 10);
          canvas.clipRect(Rect.fromCenter(center: rect2.center, width: rect2.width / 2, height: rect2.width / 2), clipOp: ui.ClipOp.difference);
          canvas.drawImageRect(
              image!,
              Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()),
              rect2, _layerPaint);
          canvas.restore();
          _linePaint.color = Colors.white;
          canvas.drawRect(rect2, _linePaint);
          break;
        case ClipType.rRect:
          final center = Offset(size.width / 2, size.height / 2);
          final rect = Rect.fromCenter(center: center, width: size.height - 20, height: size.height - 20);
          final rRect = RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: rect.width / 2, height: rect.width / 2), Radius.circular(10));
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          canvas.clipRRect(rRect);
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          canvas.restore();
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          _linePaint.color = Colors.red;
          canvas.drawRRect(rRect, _linePaint);
          break;
        case ClipType.path:
          final center = Offset(size.width / 2, size.height / 2);
          final rect = Rect.fromCenter(center: center, width: size.height - 20, height: size.height - 20);
          canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _layerPaint);
          _path.addRect(Rect.fromCenter(center: rect.center, width: rect.width / 2, height: rect.width / 2));
          canvas.clipPath(_path);
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), rect, _layerPaint);
          canvas.restore();
          _linePaint.color = Colors.white;
          canvas.drawRect(rect, _linePaint);
          _linePaint.color = Colors.red;
          canvas.drawPath(_path, _linePaint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => this != oldDelegate;

}

enum ClipType {
  rect, rRect, path
}
