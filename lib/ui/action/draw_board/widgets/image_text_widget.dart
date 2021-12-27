import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../board_config.dart';

/// Descriptions: 上面图片下面文字控件
/// User: tangzhentao
/// Date: 5:49 下午 2021/9/8
///

class ImageTextWidget extends StatefulWidget {
  final DrawMode selectMode;
  DrawMode drawMode;
  final String image;
  final String imageSelect;
  final String title;
  GestureTapCallback? onTap;

  ImageTextWidget({Key? key,
    required this.selectMode,
    required this.drawMode,
    required this.image,
    required this.imageSelect,
    this.onTap,
    this.title = '背景',
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageTextWidgetState();
  
}

class _ImageTextWidgetState extends State<ImageTextWidget> {
  late bool _isSelected;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.selectMode == widget.drawMode;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (down) {
        if (!_isSelected && !_isPressed) {
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapCancel: _handleUpOrCancel,
      onTapUp: (up) => _handleUpOrCancel(),
      child: Container(
        height: 26.w,
        width: 26.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(_isSelected || _isPressed ? widget.imageSelect : widget.image, width: 13.w, height: 13.w, fit: BoxFit.cover,),
            Text(widget.title, style: TextStyle(fontSize: 6.w, color: _isSelected || _isPressed ? boardTheme:Colors.black.withOpacity(0.65)), maxLines: 1,)
          ],
        ),
      ),
    );
  }

  /// 处理抬起或者滑出
  void _handleUpOrCancel() {
    if (!_isSelected && _isPressed) {
      setState(() {
        _isPressed = false;
      });
    }
    widget.onTap?.call();
  }
}