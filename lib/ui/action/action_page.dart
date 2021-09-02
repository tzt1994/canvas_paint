import 'package:canvas_paint/sliver/ceiling_top_custom.dart';
import 'package:canvas_paint/sliver/ceiling_top_nested.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Test_dialog_Widget.dart';
import 'bar_chart_scroll.dart';
import 'list_wheel.dart';

/// Description: 练习首页
///
/// @author tangzhentao 
/// @date 2020/8/3 

class ActionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActionPageState();

}

class ActionPageState extends State<ActionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 15.h,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (_) => CeilingTopNestedPage()));
            },
            child: Text('吸顶效果1', textAlign: TextAlign.center,),
          ),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (_) => CeilingTopCustomPage()));
            },
            child: Text('吸顶效果2', textAlign: TextAlign.center,),
          ),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (_) => BarChartScroll()));
            },
            child: Text('柱状图', textAlign: TextAlign.center,),
          ),
          ElevatedButton(
            onPressed: () => _testDialog(),
            child: Text('测试弹窗', textAlign: TextAlign.center,),
          ),
          ElevatedButton(
            onPressed: () => showModalBottomSheet(context: context, builder: (_) => Container(
              height: MediaQuery.of(context).size.height / 8 * 7,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Text("侧是是是"),
              ),
            )),
            child: Text('底部弹窗', textAlign: TextAlign.center,),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (_) => ListWheelPage()));
            },
            child: Text('listWheel', textAlign: TextAlign.center,),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            margin: EdgeInsets.only(bottom: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('中文'),
                SizedBox(width: 20,),
                Text('EN'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _testDialog() {
    showDialog(
      context: context,
      builder: (_) => TestDialogWidget(),
    );
  }
}