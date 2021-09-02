import 'package:canvas_paint/common/utils/color_utils.dart';
import 'package:canvas_paint/common/utils/navigator_utils.dart';
import 'package:canvas_paint/ui/canvas/custom_paint_page.dart';
import 'package:canvas_paint/ui/canvas/custom_painter_page.dart';
import 'package:canvas_paint/ui/canvas/path/canvas_path_page.dart';
import 'package:canvas_paint/ui/canvas/transform/canvas_transform_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bezier/bezier_page.dart';
import 'draw/canvas_draw_page.dart';

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/3 

class CanvasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CanvasPageState();

}

class CanvasPageState extends State<CanvasPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          trailing: Icon(Icons.chevron_right, color: ColorUtils.text_2,),
          title: Text('自定义widget的绘制', style: TextStyle(fontSize: 18.sp, color: ColorUtils.text_1),),
          subtitle: Text('CustomPaint', style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_2),),
          onTap: () {
            NavigatorUtils.pushCupertinoPage(context, CustomPaintPage());
          },
        ),
        ListTile(
          trailing: Icon(Icons.chevron_right, color: ColorUtils.text_2,),
          title: Text('自定义画笔', style: TextStyle(fontSize: 18.sp, color: ColorUtils.text_1),),
          subtitle: Text('CustomPainter', style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_2),),
          onTap: () {
            NavigatorUtils.pushCupertinoPage(context, CustomPainterPage());
          },
        ),
        ListTile(
          trailing: Icon(Icons.chevron_right, color: ColorUtils.text_2,),
          title: Text('Canvas的api', style: TextStyle(fontSize: 18.sp, color: ColorUtils.text_1),),
          subtitle: Text('draw函数', style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_2),),
          onTap: () {
            NavigatorUtils.pushCupertinoPage(context, CanvasDrawPage());
          },
        ),
        ListTile(
          trailing: Icon(Icons.chevron_right, color: ColorUtils.text_2,),
          title: Text('变换', style: TextStyle(fontSize: 18.sp, color: ColorUtils.text_1),),
          subtitle: Text('clip裁剪和变换', style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_2),),
          onTap: () {
            NavigatorUtils.pushCupertinoPage(context, CanvasTransformPage());
          },
        ),
        ListTile(
          trailing: Icon(Icons.chevron_right, color: ColorUtils.text_2,),
          title: Text('路径Path', style: TextStyle(fontSize: 18.sp, color: ColorUtils.text_1),),
          subtitle: Text('path，绘制任意形状', style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_2),),
          onTap: () {
            NavigatorUtils.pushCupertinoPage(context, CanvasPathPage());
          },
        ),
        ListTile(
          trailing: Icon(Icons.chevron_right, color: ColorUtils.text_2,),
          title: Text('贝塞尔曲线', style: TextStyle(fontSize: 18.sp, color: ColorUtils.text_1),),
          subtitle: Text('圆滑曲线讲解', style: TextStyle(fontSize: 14.sp, color: ColorUtils.text_2),),
          onTap: () {
            NavigatorUtils.pushCupertinoPage(context, BezierPage());
          },
        )
      ],
    );
  }

}