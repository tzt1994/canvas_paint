import 'package:canvas_paint/ui/action/draw_board/background/background_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/board/board_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/toolbar/toolbar_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/widgets/background_popup_widget.dart';
import 'package:canvas_paint/ui/action/draw_board/widgets/image_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../res.dart';
import '../board_config.dart';

/// Descriptions: 工具栏Widget
/// User: tangzhentao
/// Date: 2:34 下午 2021/9/10
///

class ToolbarWidget extends StatefulWidget {
  final ToolbarController toolbarController;
  final BoardController boardController;
  final BackgroundController backgroundController;

  ToolbarWidget({Key? key,
    required this.toolbarController,
    required this.boardController,
    required this.backgroundController,
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => _ToolbarWidgetState();
}

class _ToolbarWidgetState extends State<ToolbarWidget> {
  late final ToolbarController _toolbarController;
  late final BoardController _boardController;
  late final BackgroundController _backgroundController;

  final GlobalKey _bgKey = GlobalKey();

  @override
  void initState() {
    _toolbarController = widget.toolbarController;
    _boardController = widget.boardController;
    _backgroundController = widget.backgroundController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToolbarController>(
      create: (_) => _toolbarController,
      child: Consumer<ToolbarController>(
        builder: (context, toolbar, child) => Container(
          margin: EdgeInsets.only(bottom: 3.w),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF95B2A9), width: 0.5.w),
              borderRadius: BorderRadius.circular(2.w)
          ),
          height: 26.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.choice, title: '选择', image: Res.choice, imageSelect: Res.choice_s, onTap: () {
                if (toolbar.drawMode != DrawMode.choice) {
                  toolbar.drawMode = DrawMode.choice;
                  _boardController.drawMode = DrawMode.choice;
                }
              },),
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.pen, title: '批注', image: Res.pen, imageSelect: Res.pen_s, onTap: () {
                if (toolbar.drawMode != DrawMode.pen) {
                  toolbar.drawMode = DrawMode.pen;
                  _boardController.drawMode = DrawMode.pen;
                }
              },),
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.rubber, title: '橡皮', image: Res.rubber, imageSelect: Res.rubber_s, onTap: () {
                if (toolbar.drawMode != DrawMode.rubber) {
                  toolbar.drawMode = DrawMode.rubber;
                  _boardController.drawMode = DrawMode.rubber;
                }
              }),
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.shape, title: '形状', image: Res.shape, imageSelect: Res.shape_s,  onTap: () {
                if (toolbar.drawMode != DrawMode.shape) {
                  toolbar.drawMode = DrawMode.shape;
                  _boardController.drawMode = DrawMode.shape;
                }
              }),
              ImageTextWidget(key: _bgKey, selectMode: toolbar.drawMode, drawMode: DrawMode.background, title: '背景', image: Res.background, imageSelect: Res.background_s,  onTap: () {
                if (toolbar.drawMode != DrawMode.background) {
                  toolbar.drawMode = DrawMode.background;
                  _boardController.drawMode = DrawMode.background;
                }
                _showBackgroundPopWindow();
              }),
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.revoke, title: '撤销', image: Res.revoke, imageSelect: Res.revoke_s),
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.recovery, title: '恢复', image: Res.recovery, imageSelect: Res.recovery_s),
              ImageTextWidget(selectMode: toolbar.drawMode, drawMode: DrawMode.screen_shot, title: '截屏', image: Res.screen_shot, imageSelect: Res.screen_shot_s,  onTap: () {
                if (toolbar.drawMode != DrawMode.screen_shot) {
                  toolbar.drawMode = DrawMode.screen_shot;
                  _boardController.drawMode = DrawMode.screen_shot;
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showBackgroundPopWindow() {
    showCupertinoModalPopup(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_) => BackgroundPopupWidget(bottom: 30.w, left: _bgKey.currentContext?.findRenderObject()?.paintBounds.left),
    );
  }
}