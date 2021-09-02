
import 'package:canvas_paint/common/webview_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

/// Descriptions: 路径操作
/// User: tangzhentao
/// Date: 9:15 上午 2021/8/30
///

class PathOperationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
              children: [
                TextSpan(text: 'PathFillType,路径填充规则,详情看'),
                TextSpan(
                    text: '张鑫旭文章', 
                    style: TextStyle(fontSize: 16.sp, color: Colors.blue, decoration: TextDecoration.underline), 
                    recognizer: TapGestureRecognizer()..onTap = () { 
                      Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewPage(url: 'https://www.zhangxinxu.com/wordpress/2018/10/nonzero-evenodd-fill-mode-rule/')));
                    },
                ),
              ]
            ),
          ),
          SizedBox(height: 5.w,),
          Row(
            children: [
              Expanded(child: Text('${PathFillType.nonZero}', textAlign: TextAlign.center,)),
              Expanded(child: Text('${PathFillType.evenOdd}', textAlign: TextAlign.center,)),
            ],
          ),
          CustomPaint(
            size: Size(double.infinity, (ScreenUtil().screenWidth - 20.w) / 2),
            painter: _PathOperationPainter(style: PaintingStyle.fill),
          ),
          SizedBox(height: 20.w,),
          Text('Rect getBounds(),获取路径所占据的矩形', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),),
          Text('白线为二阶贝塞尔曲线\n'
              '红线为曲线所占据的矩形范围', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathOperationPainter(type: OperationType.getBounds),
          ),
          SizedBox(height: 20.w,),
          Text('bool contains(Offset point)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('判断点是否在路径上,返回bool', style: TextStyle(fontSize: 14.sp),),
          SizedBox(height: 20.w,),
          Text('Path shit(Offset offset)', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
          Text('path按照offset的值偏移返回一个新的path\n'
              '白线原位置线\n红线是shift(Offset(size.width / 2, 0))后的线', style: TextStyle(fontSize: 14.sp),),
          CustomPaint(
            size: Size(double.infinity, 100.w),
            painter: _PathOperationPainter(type: OperationType.shift),
          ),
        ],
      ),
    );
  }

}

class _PathOperationPainter extends CustomPainter {
  final Paint _savePaint = Paint()..isAntiAlias = true;
  final Paint _paint = Paint()
    ..isAntiAlias = true
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final Path _path = Path();

  bool close;

  OperationType type;

  _PathOperationPainter({this.type = OperationType.pathFillType, this.close = false, PaintingStyle style = PaintingStyle.stroke}) {
    _paint.style = style;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTRB(0, 0, size.width, size.height), _savePaint);
    canvas.drawColor(Colors.blue, BlendMode.color);
    switch(type) {
      case OperationType.pathFillType:
        // ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        //     textAlign: TextAlign.center,
        //     fontWeight: FontWeight.w300,
        //     fontSize: 12.sp,
        //     fontStyle: FontStyle.normal
        // ));
        // pb.pushStyle(ui.TextStyle(color: Colors.white));
        // pb.addText('${PathFillType.nonZero}');
        // ui.Paragraph ph = pb.build()..layout(ui.ParagraphConstraints(width: 120.w));
        // ui.canvas.drawParagraph(ph, Offset(size.width / 12, 10.w));
        _path.fillType = PathFillType.nonZero;
        _path.moveTo(size.width / 8, size.height / 4);
        _path.lineTo(size.width / 8 * 3, size.height / 7 * 3);
        _path.lineTo(size.width / 4 , size.height / 8 * 7);
        _path.lineTo(size.width / 8, size.height / 4);
        _path.lineTo(size.width / 4, size.height / 8);
        _path.lineTo(size.width / 8 * 3, size.height / 16 * 13);
        _path.close();
        canvas.drawPath(_path, _paint);
        _path.reset();
        _path.fillType = PathFillType.evenOdd;
        _path.moveTo(size.width / 8 * 5, size.height / 4);
        _path.lineTo(size.width / 8 * 7, size.height / 7 * 3);
        _path.lineTo(size.width / 4 * 3 , size.height / 8 * 7);
        _path.lineTo(size.width / 8 * 5, size.height / 4);
        _path.lineTo(size.width / 4 * 3, size.height / 8);
        _path.lineTo(size.width / 8 * 7, size.height / 16 * 13);
        _path.close();
        canvas.drawPath(_path, _paint);
        break;
      case OperationType.getBounds:
        _paint.color = Colors.white;
        _path.moveTo(size.width / 4, size.height / 8 * 7);
        _path.quadraticBezierTo(size.width / 2, 10, size.width / 4 * 3, size.height / 8 * 7);
        canvas.drawPath(_path, _paint);
        _paint.color = Colors.red;
        canvas.drawRect(_path.getBounds(), _paint);
        break;
      case OperationType.shift:
        _paint.color = Colors.white;
        _path.moveTo(size.width / 8, size.height / 8 * 7);
        _path.quadraticBezierTo(size.width / 4, 10, size.width / 8 * 3, size.height / 8 * 7);
        canvas.drawPath(_path, _paint);
        _paint.color = Colors.red;
        canvas.drawPath(_path.shift(Offset(size.width / 2, 0)), _paint);
        break;
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PathOperationPainter oldDelegate) => this != oldDelegate;
}

enum OperationType {
  pathFillType,getBounds,shift
}