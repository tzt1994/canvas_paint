import 'package:canvas_paint/common/common_widget.dart';
import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/3 

class CustomPaintPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomPaintPageState();

}

class CustomPaintPageState extends State<CustomPaintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cpAppBar(
        context,
        title: 'CustomPaint',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
        child: Column(
          children: <Widget>[
            Text(
              '自定义绘制的Widget',
              style: TextStyle(color: ColorUtils.text_1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
            Text(
              '使用CustomPaint来绘制规则或不规则的UI，构造函数:\n',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            Container(
              color: ColorUtils.white,
              alignment: Alignment.center,
              child: Text(
                'const CustomPaint({\n'
                    '\t\t\t\tKey key,\n'
                    '\t\t\t\tthis.painter,\n'
                    '\t\t\t\tthis.foregroundPainter,\n'
                    '\t\t\t\tthis.size = Size.zero,\n'
                    '\t\t\t\tthis.isComplex = false,\n'
                    '\t\t\t\tthis.willChange = false,\n'
                    '\t\t\t\tWidget child, //子节点，可以为空\n'
                    '\t\t\t\t})',
                style: TextStyle(color: ColorUtils.text_2, fontSize: 14.sp),),
            ),
            Text(
              '· painter: 背景画笔，显示在子节点后面\n'
                  '· foregroundPainter: 前景画笔，显示在子节点前面\n'
                  '· size: 当child为null时，代表默认绘制区域大小，如果有有child参数，画布尺寸为child尺寸。如果有child'
                  '但是想指定画布大小，使用SizeBox包裹CustomPaint实现\n'
                  '· isComplex: 是否复杂的绘制，是的话Flutter会都应用一些缓存策略来减少重复=渲染的开销\n'
                  '· willChange: 和isComplex配合使用，当启动缓存时，该属性代表在下一帧中绘制是否会改变\n'
                  '· child: CustomPaint的子节点，可以为空\n',
              style: TextStyle(color: ColorUtils.text_1, fontSize: 14.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: CustomPaint(
                    size: Size(100.w, 100.w),
                    foregroundPainter: ForegroundPainter(),
                    painter: BackgroundPainter(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.green,
                        width: 75.w,
                        height: 75.w,
                        padding: EdgeInsets.only(top: 5.w, left: 5.w),
                        alignment: Alignment.topLeft,
                        child: Text('child', style: TextStyle(color: Colors.black),),
                      ),
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(100.w, 100.w),
                  foregroundPainter: ForegroundPainter(),
                  painter: BackgroundPainter(),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                text: "注意：\n",
                style: TextStyle(fontSize: 16.sp, color: ColorUtils.red),
                children: [
                  TextSpan(
                    text: '如果CustomPaint有子节点，为了避免子节点不必要的重绘并提高性能'
                        '，通常情况下都会将子节点包裹在RepaintBoundary Widget中，'
                        '这样会在绘制时创建一个新的绘制层（Layer），其子Widget将在新的Layer上绘制'
                        '，而父Widget将在原来Layer上绘制，也就是说RepaintBoundary '
                        '子Widget的绘制将独立于父Widget的绘制，RepaintBoundary会隔离其子'
                        '节点和CustomPaint本身的绘制边界, 如下：\n',
                    style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_1),
                  ),
                  WidgetSpan(
                    child: Container(
                      color: ColorUtils.white,
                      alignment: Alignment.center,
                      child: Text(
                        'CustomPaint(\n'
                            '\t\t\t\tsize: Size(300, 300), //指定画布大小\n'
                            '\t\t\t\tpainter: MyPainter(),\n'
                            '\t\t\t\tchild: RepaintBoundary(child:...)),\n'
                            '\t\t\t\t)',
                        style: TextStyle(fontSize: 12.sp, color: ColorUtils.text_2),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForegroundPainter extends CustomPainter {
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width / 2, height: size.height / 2), _paint);
    canvas.drawColor(Colors.blue, BlendMode.color);
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w300,
          fontSize: 10.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pb.pushStyle(ui.TextStyle(color: Color(0xff000000)));
    pb.addText('foreground');
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: double.infinity));
    canvas.drawParagraph(paragraph, Offset(size.width / 4, size.height / 4 + 5.w));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ForegroundPainter oldDelegate) => this != oldDelegate;
}

class BackgroundPainter extends CustomPainter {
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _paint);
    canvas.drawColor(Colors.red, BlendMode.color);
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
          fontStyle: FontStyle.normal,
        )
    );
    pb.pushStyle(ui.TextStyle(color: Color(0xff000000)));
    pb.addText('painter');
    ui.Paragraph paragraph = pb.build()..layout(ui.ParagraphConstraints(width: double.infinity));
    canvas.drawParagraph(paragraph, Offset(5.w, 5.w));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) => this != oldDelegate;
}