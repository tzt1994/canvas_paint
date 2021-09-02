import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Description: 可滑动柱状图表
///
/// @author tangzhentao 
/// @date 2020/3/23 

class BarChart extends StatefulWidget {
  double width, height;
  double fontSize;
  List<BarEntry> data;

  BarChart({required this.data, this.width = double.infinity, this.height = double.infinity, this.fontSize = 16});

  @override
  State<StatefulWidget> createState() {
    return BarChartState(data: data, width: width, height: height, fontSize: fontSize);
  }
}

class BarChartState extends State<BarChart> {
  double width, height;
  double fontSize;
  List<BarEntry> data;

  BarChartState({required this.data, this.width = double.infinity, this.height = double.infinity, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {

    return Container(
        height: height,
        width: width,
        child: Row(
          children: <Widget>[
            CustomPaint(
              size: Size(_gexTextSize(fontSize).width, double.infinity),
              painter: YAxisPainter(data: data),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: CustomPaint(
                    size: Size(data.length * 500.0, double.infinity),
                    painter: BarChartPainter(data: data),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  Size _gexTextSize(double fontsize) {
    TextPainter painter = TextPainter(
        text:  TextSpan(
            text: 'Text',
            style: TextStyle(fontSize: fontsize, color: Colors.black)),
        textDirection: TextDirection.ltr
    );
    painter.layout();

    return painter.size;
  }
}

/// y轴自定义widget
class YAxisPainter extends CustomPainter {
  List<BarEntry> data;

  YAxisPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    var paiter = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.green;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paiter);
  }

  @override
  bool shouldRepaint(YAxisPainter oldDelegate) {
    return this.data != oldDelegate.data;
  }

}

/// 柱状图自定义widget
class BarChartPainter extends  CustomPainter{
  List<BarEntry> data;

  BarChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    size.width;
    size.height;

    var paiter = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.blue;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paiter);

    paiter.color = Colors.red;
    canvas.drawRect(Rect.fromLTRB(10, size.height / 2, 30, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(40, size.height / 2, 60, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(70, size.height / 2, 90, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(100, size.height / 2, 120, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(130, size.height / 2, 150, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(160, size.height / 2, 180, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(190, size.height / 2, 210, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(220, size.height / 2, 240, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(250, size.height / 2, 270, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(280, size.height / 2, 300, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(310, size.height / 2, 330, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(340, size.height / 2, 360, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(370, size.height / 2, 390, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(400, size.height / 2, 420, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(430, size.height / 2, 450, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(460, size.height / 2, 480, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(490, size.height / 2, 510, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(520, size.height / 2, 540, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(550, size.height / 2, 570, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(580, size.height / 2, 600, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(610, size.height / 2, 630, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(640, size.height / 2, 660, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(670, size.height / 2, 690, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(700, size.height / 2, 720, size.height), paiter);
    canvas.drawRect(Rect.fromLTRB(730, size.height / 2, 750, size.height), paiter);
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) {
    return oldDelegate.data != data;
  }

}

class BarEntry {
  double y;
  String x;

  BarEntry({this.x = '', this.y = 0.0});
}