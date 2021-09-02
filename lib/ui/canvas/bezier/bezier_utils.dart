import 'package:flutter/cupertino.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 9:58 上午 2021/8/27
///

class BezierUtils {
  factory BezierUtils() => _instance;
  static final BezierUtils _instance = BezierUtils._internal();
  static BezierUtils get instance => _instance;

  BezierUtils._internal();

  /// 计算所有控制点列表
  /// [u] 比例
  /// [controllerList] 控制点列表
  List<List<Offset>> calculateAllLowPoints(double u, List<Offset> controllerList) {
    final List<List<Offset>> allLowControllerList = [];
    final lowControllerList = calculateLowPoints(u, controllerList);
    allLowControllerList.add(lowControllerList);
    /// 二阶以上的贝塞尔曲线继续获取所有低阶控制点列表
    if (lowControllerList.length > 2) {
      allLowControllerList.addAll(calculateAllLowPoints(u, lowControllerList));
    }
    return allLowControllerList;
  }

  /// 计算出低一阶控制点列表
  /// [u] 比例
  /// [controllerList] 控制点列表
  List<Offset> calculateLowPoints(double u, List<Offset> controllerList) {
    final List<Offset> lowControllerList = [];
    var p0 = controllerList[0];
    /// 遍历从下标1开始的子集合
    controllerList.sublist(1, controllerList.length).forEach((p1) {
      lowControllerList.add(Offset((1 - u) * p0.dx + u * p1.dx, (1 - u) * p0.dy + u * p1.dy));
      p0 = p1;
    });
    return lowControllerList;
  }

  /// 构建高阶贝塞尔曲线，具体点数由参数frame决定
  /// [controllerList] 控制点坐标
  /// [frame] 帧率决定点的个数, 默认帧率60
  List<Offset> buildBezier(List<Offset> controllerList, { int frame = 60}) {
    final List<Offset> pointList = [];
    final delta  = 1.0 / frame;
    /// 阶数 = 控制点 - 1
    final order = controllerList.length - 1;
    /// 循环递增
    var u = 0.0;
    do {
      pointList.add(Offset(
        _calculatePointCoordinate(ValueType.x_type, u, order, 0, controllerList),
        _calculatePointCoordinate(ValueType.y_type, u, order, 0, controllerList),
      ));
      u += delta;
    } while (u <= 1.0);
    return pointList;
  }

  /// 计算坐标，贝塞尔曲线的核心
  /// [type] x_type表示x轴的坐标， y_type表示y轴的坐标
  /// [u] 当前比例
  /// [k] 阶数
  /// [p] 当前点下标
  /// [controllerPointList] 控制点集合
  double _calculatePointCoordinate(ValueType type, double u, int k, int p, List<Offset> controllerPointList) {
    /// 公式解说：（p表示坐标点，后面的数字只是区分）
    /// 场景：有一条线p1到p2，p0在中间，求p0的坐标
    /// p1◉--------○----------------◉p2
    ///            u    p0
    ///公式：p0 = p1+u*(p2-p1) 整理得出 p0 = (1-u)*p1+u*p2
    if (k == 1) {
      /// 一阶贝塞尔即直线，直接返回
      var p1 = 0.0;
      var p2 = 0.0;
      if (type == ValueType.x_type) {
        p1 = controllerPointList[p].dx;
        p2 = controllerPointList[p + 1].dx;
      } else {
        p1 = controllerPointList[p].dy;
        p2 = controllerPointList[p + 1].dy;
      }
      return (1 - u) * p1 + u * p2;
    } else {
      /// 这里应用了递归的思想：
      /// 1阶贝塞尔曲线的端点 依赖于 2阶贝塞尔曲线
      /// 2阶贝塞尔曲线的端点 依赖于 3阶贝塞尔曲线
      /// ....
      /// n-1阶贝塞尔曲线的端点 依赖于 n阶贝塞尔曲线
      ///
      ///1阶贝塞尔曲线 则为 真正的贝塞尔曲线存在的点
      return (1 - u) * _calculatePointCoordinate(type, u, k - 1, p, controllerPointList) + u * _calculatePointCoordinate(type, u, k - 1, p + 1, controllerPointList);
    }
  }
}


enum ValueType {
  x_type,y_type
}