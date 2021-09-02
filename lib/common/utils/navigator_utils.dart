import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/3 

class NavigatorUtils {

  static Future<T> pushMaterialPage<T>(BuildContext context, Widget widget) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  static Future<T> pushCupertinoPage<T>(BuildContext context, Widget widget) async {
    return await Navigator.of(context).push(CupertinoPageRoute(builder: (context) => widget));
  }
}