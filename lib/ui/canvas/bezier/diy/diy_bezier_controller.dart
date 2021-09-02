import 'package:flutter/material.dart';

/// Descriptions: diy贝塞尔控制器
/// User: tangzhentao
/// Date: 2:01 下午 2021/8/27
///

class DiyBezierController extends ChangeNotifier {
  /// 拽动类型，默认是自由
  DragType _dragType = DragType.free;
  DragType get dragType => _dragType;
  set dragType(DragType type) {
    if (type != _dragType) {
      _dragType = type;
      notifyListeners();
    }
  }

  /// 是否显示辅助线
  bool _showAssistLine = true;
  bool get showAssistLine => _showAssistLine;
  set showAssistLine(bool assist) {
    if (assist != _showAssistLine) {
      _showAssistLine = assist;
      notifyListeners();
    }
  }

  /// 滚动类型
  ScrollType? _scrollType;
  ScrollType? get scrollType => _scrollType;
  set scrollType(ScrollType? type) {
    if (type != _scrollType) {
      _scrollType = type;
      notifyListeners();
    }
  }
  /// 左边，上边，右边，下边线是否是选中状态
  bool _isLeftLine = false;
  bool get isLeftLine => _isLeftLine;
  bool _isTopLine = false;
  bool get isTopLine => _isTopLine;
  bool _isRightLine = false;
  bool get isRightLine => _isRightLine;
  bool _isBottomLine = false;
  bool get isBottomLine => _isBottomLine;
  /// 左，上，右，下点是否选中状态
  bool _isLeftPoint = false;
  bool get isLeftPoint => _isLeftPoint;
  bool _isLeftTopPoint = false;
  bool get isLeftTopPoint => _isLeftTopPoint;
  bool _isLeftBottomPoint = false;
  bool get isLeftBottomPoint => _isLeftBottomPoint;
  bool _isTopPoint = false;
  bool get isTopPoint => _isTopPoint;
  bool _isTopLeftPoint = false;
  bool get isTopLeftPoint => _isTopLeftPoint;
  bool _isTopRightPoint = false;
  bool get isTopRightPoint => _isTopRightPoint;
  bool _isRightPoint = false;
  bool get isRightPoint => _isRightPoint;
  bool _isRightTopPoint = false;
  bool get isRightTopPoint => _isRightTopPoint;
  bool _isRightBottomPoint = false;
  bool get isRightBottomPoint => _isRightBottomPoint;
  bool _isBottomPoint = false;
  bool get isBottomPoint => _isBottomPoint;
  bool _isBottomLeftPoint = false;
  bool get isBottomLeftPoint => _isBottomLeftPoint;
  bool _isBottomRightPoint = false;
  bool get isBottomRightPoint => _isBottomRightPoint;

  final double pointRadius = 6;
  final double u = 0.55;
  final double radius = 100;
  late Offset left;
  late Rect leftRect;
  late Offset top;
  late Rect topRect;
  late Offset right;
  late Rect rightRect;
  late Offset bottom;
  late Rect bottomRect;
  /// 计算控制点
  late Offset leftTop;
  late Rect leftTopRect;
  late Offset leftBottom;
  late Rect leftBottomRect;
  late Offset topLeft;
  late Rect topLefRect;
  late Offset topRight;
  late Rect topRightRect;
  late Offset rightTop;
  late Rect rightTopRect;
  late Offset rightBottom;
  late Rect rightBottomRect;
  late Offset bottomLeft;
  late Rect bottomLeftRect;
  late Offset bottomRight;
  late Rect bottomRightRect;

  DiyBezierController() {
    _resetPointAndRect();
  }

  /// 重置点和矩形范围
  void _resetPointAndRect() {
    _scrollType = null;
    /// 左边点及控制点
    left = Offset(-radius, 0);
    leftTop = Offset(-radius, -radius * u);
    leftBottom = Offset(-radius, radius * u);
    /// 顶部点及控制点
    top = Offset(0, -radius);
    topLeft = Offset(u * -radius, -radius);
    topRight = Offset(radius * u, -radius);
    /// 右边点及控制点
    right = Offset(radius, 0);
    rightTop = Offset(radius, u * -radius);
    rightBottom = Offset(radius, u * radius);
    /// 底部点及控制点
    bottom = Offset(0, radius);
    bottomLeft = Offset(-radius * u, radius);
    bottomRight = Offset(radius * u, radius);
    _calculateRect();
  }

  /// 计算个点的点击范围
  void _calculateRect() {
    /// 左边
    leftRect = Rect.fromLTRB(left.dx - pointRadius, left.dy - pointRadius, left.dx + pointRadius, left.dy + pointRadius);
    leftTopRect = Rect.fromLTRB(leftTop.dx - pointRadius, leftTop.dy - pointRadius, leftTop.dx + pointRadius, leftTop.dy + pointRadius);
    leftBottomRect = Rect.fromLTRB(leftBottom.dx - pointRadius, leftBottom.dy - pointRadius, leftBottom.dx + pointRadius, leftBottom.dy + pointRadius);
    /// 上面
    topRect = Rect.fromLTRB(top.dx - pointRadius, top.dy - pointRadius, top.dx + pointRadius, top.dy + pointRadius);
    topLefRect = Rect.fromLTRB(topLeft.dx - pointRadius, topLeft.dy - pointRadius, topLeft.dx + pointRadius, topLeft.dy + pointRadius);
    topRightRect = Rect.fromLTRB(topRight.dx - pointRadius, topRight.dy - pointRadius, topRight.dx + pointRadius, topRight.dy + pointRadius);
    /// 右边
    rightRect = Rect.fromLTRB(right.dx - pointRadius, right.dy - pointRadius, right.dx + pointRadius, right.dy + pointRadius);
    rightTopRect = Rect.fromLTRB(rightTop.dx - pointRadius, rightTop.dy - pointRadius, rightTop.dx + pointRadius, rightTop.dy + pointRadius);
    rightBottomRect = Rect.fromLTRB(rightBottom.dx - pointRadius, rightBottom.dy - pointRadius, rightBottom.dx + pointRadius, rightBottom.dy + pointRadius);
    /// 下边
    bottomRect = Rect.fromLTRB(bottom.dx - pointRadius, bottom.dy - pointRadius, bottom.dx + pointRadius, bottom.dy + pointRadius);
    bottomLeftRect = Rect.fromLTRB(bottomLeft.dx - pointRadius, bottomLeft.dy - pointRadius, bottomLeft.dx + pointRadius, bottomLeft.dy + pointRadius);
    bottomRightRect = Rect.fromLTRB(bottomRight.dx - pointRadius, bottomRight.dy - pointRadius, bottomRight.dx + pointRadius, bottomRight.dy + pointRadius);
  }

  /// 复位
  void reset() {
    print('复位');
    _resetPointAndRect();
    notifyListeners();
  }

  /// 打印控制点
  void printPoint() {
    print('left:$left  leftTop:$leftTop  topLeft:$topLeft');
    print('top:$top  topRight:$topRight rightTop:$rightTop');
    print('right:$right  rightBottom:$rightBottom bottomRight:$bottomRight');
    print('bottom:$bottom  bottomLeft:$bottomLeft leftBottom:$leftBottom');
  }

  /// 计算拽动类型，线，点的状态
  void calculateScrollTypeAndLinePointState(Offset position) {
    if (leftRect.contains(position)) {
      _scrollType = ScrollType.left;
    } else if (leftTopRect.contains(position)) {
      _scrollType = ScrollType.left_top;
    } else if (topLefRect.contains(position)) {
      _scrollType = ScrollType.top_left;
    } else if (topRect.contains(position)) {
      _scrollType = ScrollType.top;
    } else if (topRightRect.contains(position)) {
      _scrollType = ScrollType.top_right;
    } else if (rightTopRect.contains(position)) {
      _scrollType = ScrollType.right_top;
    } else if (rightRect.contains(position)) {
      _scrollType = ScrollType.right;
    } else if (rightBottomRect.contains(position)) {
      _scrollType = ScrollType.right_bottom;
    } else if (bottomRightRect.contains(position)) {
      _scrollType = ScrollType.bottom_right;
    } else if (bottomRect.contains(position)) {
      _scrollType = ScrollType.bottom;
    } else if (bottomLeftRect.contains(position)) {
      _scrollType = ScrollType.bottom_left;
    } else if (leftBottomRect.contains(position)) {
      _scrollType = ScrollType.left_bottom;
    }
    print('拽动类型 $_scrollType');
    /// 计算线状态
    _isLeftLine = (_scrollType == ScrollType.left || _scrollType == ScrollType.left_top || _scrollType == ScrollType.left_bottom) && _dragType == DragType.three;
    _isTopLine = (_scrollType == ScrollType.top || _scrollType == ScrollType.top_right || _scrollType == ScrollType.top_left) && _dragType == DragType.three;
    _isRightLine = (_scrollType == ScrollType.right || _scrollType == ScrollType.right_bottom || _scrollType == ScrollType.right_top) && _dragType == DragType.three;
    _isBottomLine = (_scrollType == ScrollType.bottom || _scrollType == ScrollType.bottom_left || _scrollType == ScrollType.left_bottom) && _dragType == DragType.three;
    /// 计算点状态
    _isLeftPoint = _scrollType == ScrollType.left ||
        (_scrollType == ScrollType.right && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.left_top || _scrollType == ScrollType.left_bottom) && _dragType == DragType.three);
    _isLeftTopPoint = _scrollType == ScrollType.left_top ||
        (_scrollType == ScrollType.right_top && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.left || _scrollType == ScrollType.left_bottom) && _dragType == DragType.three);
    _isLeftBottomPoint = _scrollType == ScrollType.left_bottom ||
        (_scrollType == ScrollType.right_bottom && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.left || _scrollType == ScrollType.left_top) && _dragType == DragType.three);
    _isTopPoint = _scrollType == ScrollType.top ||
        (_scrollType == ScrollType.bottom && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.top_right || _scrollType == ScrollType.top_left) && _dragType == DragType.three);
    _isTopLeftPoint = _scrollType == ScrollType.top_left ||
        (_scrollType == ScrollType.top_right && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.top || _scrollType == ScrollType.top_right) && _dragType == DragType.three);
    _isTopRightPoint = _scrollType == ScrollType.top_right ||
        (_scrollType == ScrollType.top_left && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.top || _scrollType == ScrollType.top_left) && _dragType == DragType.three);
    _isRightPoint = _scrollType == ScrollType.right ||
        (_scrollType == ScrollType.left && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.right_bottom || _scrollType == ScrollType.right_top) && _dragType == DragType.three);
    _isRightTopPoint = _scrollType == ScrollType.right_top ||
        (_scrollType == ScrollType.left_top && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.right || _scrollType == ScrollType.right_bottom) && _dragType == DragType.three);
    _isRightBottomPoint = _scrollType == ScrollType.right_bottom ||
        (_scrollType == ScrollType.left_bottom && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.right || _scrollType == ScrollType.right_top) && _dragType == DragType.three);
    _isBottomPoint = _scrollType == ScrollType.bottom ||
        (_scrollType == ScrollType.top && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.bottom_left || _scrollType == ScrollType.bottom_right) && _dragType == DragType.three);
    _isBottomLeftPoint = _scrollType == ScrollType.bottom_left ||
        (_scrollType == ScrollType.bottom_right && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.bottom || _scrollType == ScrollType.bottom_right) && _dragType == DragType.three);
    _isBottomRightPoint = _scrollType == ScrollType.bottom_right ||
        (_scrollType == ScrollType.bottom_left && (_dragType == DragType.mirror_diff_direction ||_dragType == DragType.mirror_same_direction)) ||
        ((_scrollType == ScrollType.bottom || _scrollType == ScrollType.bottom_left) && _dragType == DragType.three);
    notifyListeners();
  }

  /// 拽动中
  void panUpdate(Offset distance) {
    if (isLeftPoint) { left = left.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.right ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.right ? 1: -1) * distance.dy); }
    if (isLeftTopPoint) { leftTop = leftTop.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.right_top ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.right_top ? 1: -1) * distance.dy); }
    if (isLeftBottomPoint) { leftBottom = leftBottom.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.right_bottom ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.right_bottom ? 1: -1) * distance.dy); }
    if (isTopPoint) { top = top.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom ? 1: -1) * distance.dy); }
    if (isTopLeftPoint) { topLeft = topLeft.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.top_right ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.top_right ? 1: -1) * distance.dy); }
    if (isTopRightPoint) { topRight = topRight.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.top_left ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.top_left ? 1: -1) * distance.dy); }
    if (isRightPoint) { right = right.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.left ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.left ? 1: -1) * distance.dy); }
    if (isRightTopPoint) { rightTop = rightTop.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.left_top ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.left_top ? 1: -1) * distance.dy); }
    if (isRightBottomPoint) { rightBottom = rightBottom.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.left_bottom ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.left_bottom ? 1: -1) * distance.dy); }
    if (isBottomPoint) { bottom = bottom.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.top ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom ? 1: -1) * distance.dy); }
    if (isBottomLeftPoint) { bottomLeft = bottomLeft.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom_right ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom_right ? 1: -1) * distance.dy); }
    if (isBottomRightPoint) { bottomRight = bottomRight.translate((_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom_left ? 1: -1) * distance.dx, (_dragType == DragType.mirror_diff_direction && _scrollType == ScrollType.bottom_left ? 1: -1) * distance.dy); }
    _calculateRect();
    notifyListeners();
    if (distance.dx.abs() > 1 || distance.dy.abs() > 1) {

    }
  }

  /// 拽动结束，重置类，以及线、点的状态
  void panEnd() {
    _scrollType = null;
    _isLeftLine = false;
    _isTopLine = false;
    _isRightLine = false;
    _isBottomLine = false;
    _isLeftPoint = false;
    _isLeftTopPoint = false;
    _isLeftBottomPoint = false;
    _isTopPoint = false;
    _isTopLeftPoint = false;
    _isTopRightPoint = false;
    _isRightPoint = false;
    _isRightTopPoint = false;
    _isRightBottomPoint = false;
    _isBottomRightPoint = false;
    _isBottomPoint = false;
    _isBottomLeftPoint = false;
    notifyListeners();
  }
}

/// 拽动类型
enum DragType {
  /// 自由拽动
  free,
  /// 三点拽动
  three,
  /// 镜像同向
  mirror_same_direction,
  /// 镜像异向
  mirror_diff_direction,
}

/// 滚动类型
enum ScrollType {
  /// 左边点
  left,
  /// 左上控制点
  left_top,
  /// 左下控制点
  left_bottom,
  /// 上边点
  top,
  /// 上左控制点
  top_left,
  /// 上右控制点
  top_right,
  /// 右边点
  right,
  /// 右上控制点
  right_top,
  /// 右下控制点
  right_bottom,
  /// 下边点
  bottom,
  /// 下左控制点
  bottom_left,
  /// 下右控制点
  bottom_right,
}