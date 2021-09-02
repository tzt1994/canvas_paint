import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:canvas_paint/common/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:canvas_paint/common/utils/cp_extensions.dart';

import '../../../res.dart';

/// Description: 绘制图片
///
/// @author tangzhentao 
/// @date 2020/8/4 

enum DrawType {
  imageRect, image, imageNine, atlas
}

class DrawImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawImagePageState();

}

class DrawImagePageState extends State<DrawImagePage> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    ImageUtils.getImageByAsset(context, Res.batman, width: 180, height: 180).then((value) {
      setState(() {
        _image = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.w),
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10.w, bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'drawImageRect(Image image, Rect src, Rect dst, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '矩形框内绘制图片\nimage:图片\nsrc:要绘制的图片内容\ndst:绘制到的目标区域\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawImagePainter(image: _image,),
            ),
            SizedBox(height: 10.w,),
            Text(
              'drawImage(Image image, Offset offset, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '按照图片原始尺寸从固定位置开始绘制图片\nimage:图片\noffset:绘制区域的左上角\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 80.w),
              painter: DrawImagePainter(image: _image, type: DrawType.image, color: Colors.green),
            ),
            SizedBox(height: 10.w,),
            Text(
              'drawImageNine(Image image, Rect center, Rect dst, Paint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '矩形框内绘制点9图片\nimage:图片\nsrc:要绘制的图片内容\ndst:绘制到的目标区域\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawImagePainter(image: _image, type: DrawType.imageNine, color: Colors.blue),
            ),
            SizedBox(height: 10.w,),
            Text(
              'drawAtlas(Image atlas,'
                  '\nList<RSTransform> transforms,'
                  '\nList<Rect> rects,'
                  '\nList<Color>? colors,'
                  '\nBlendMode? blendMode,'
                  '\nRect? cullRect,'
                  '\nPaint ui.paint)',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '矩形框内绘制点9图片\nimage:图片\nsrc:要绘制的图片内容\ndst:绘制到的目标区域\nui.paint:画笔',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            CustomPaint(
              size: Size(double.infinity, 100.w),
              painter: DrawImagePainter(image: _image, type: DrawType.atlas, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }

}

class DrawImagePainter extends CustomPainter {
  late Color color;
  late DrawType type;
  ui.Image? image;
  ui.PictureRecorder? pictureRecorder;
  final colorPaint = Paint()
    ..isAntiAlias = true;

  final List<Offset> offsets = [];
  late Float32List points;

  DrawImagePainter({this.image, this.color = Colors.red, this.type = DrawType.imageRect}) {
    colorPaint..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(size.toRect, colorPaint);
    canvas.drawColor(color, BlendMode.color);
    canvas.restore();
    canvas.saveLayer(size.toRect, colorPaint);
    if (image != null) {
      switch (type) {
        case DrawType.imageRect:
          canvas.drawImageRect(image!, Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.height.toDouble()), Rect.fromLTRB(size.centerX - size.height / 8 * 3, size.height / 8, size.centerX + size.height / 8 * 3, size.height / 8 * 7),colorPaint);
          break;
        case DrawType.image:
          canvas.drawImage(image!, Offset(size.width / 4, 0),colorPaint);
          break;
        case DrawType.imageNine:
          canvas.drawImageNine(image!, Rect.fromLTRB(0, 0, image!.width.toDouble() / 3, image!.height.toDouble() / 3), Rect.fromLTRB(size.centerX - size.height / 8 * 3, size.height / 8, size.centerX + size.height / 8 * 3, size.height / 8 * 7),colorPaint);
          break;
        case DrawType.atlas:
          canvas.drawAtlas(image!, [ui.RSTransform.fromComponents(rotation: 90, scale: 0, anchorX: 0, anchorY: 0, translateX: 0, translateY: 0)], [Rect.fromLTRB(size.centerX - size.height / 8 * 3, size.height / 8, size.centerX + size.height / 8 * 3, size.height / 8 * 7)], null, null, null, colorPaint);
          break;
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(DrawImagePainter oldDelegate) => this != oldDelegate;

}