import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 11:19 上午 2021/9/13
///

class BackgroundPopupWidget extends StatefulWidget {
  double? bottom;
  double? left;

  BackgroundPopupWidget({Key? key, this.left, this.bottom}):super(key: key);

  @override
  State<StatefulWidget> createState() => _BackgroundPopupWidgetState();
}

class _BackgroundPopupWidgetState extends State<BackgroundPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: widget.left?? 0, bottom: widget.bottom?? 0),
      width: 91.w,
      height: 68.w,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3.w), border: Border.all(width: 0.5.w, color: Color(0xFF95B2A9))),
    );
  }

}