import 'package:canvas_paint/ui/action/draw_board/background/background_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/background/background_painter.dart';
import 'package:canvas_paint/ui/action/draw_board/board/board_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/board/board_painter.dart';
import 'package:canvas_paint/ui/action/draw_board/toolbar/toolbar_controller.dart';
import 'package:canvas_paint/ui/action/draw_board/toolbar/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 9:59 上午 2021/9/8
///

class DrawBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawBoardPage();
}

class _DrawBoardPage extends State<DrawBoardPage> {
  final BackgroundController _bgController = BackgroundController();
  final BoardController _boardController = BoardController();
  final ToolbarController _toolbarController = ToolbarController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight),
            foregroundPainter: BackgroundPainter(controller: _bgController),
            painter: BoardPainter(controller: _boardController),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ToolbarWidget(toolbarController: _toolbarController, boardController: _boardController, backgroundController: _bgController,),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }
}