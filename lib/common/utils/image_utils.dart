import 'dart:ui' as ui;

import 'package:canvas_paint/main.dart';
import 'package:flutter/cupertino.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 10:41 AM 4/15/21
///

class ImageUtils {

  /// 获取资源文件
  static Future<ui.Image> getImageByAsset(BuildContext context, String asset, {int? width, int? height}) async {
    final data = await DefaultAssetBundle.of(context).load(asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width, targetWidth: height);
    final fi = await codec.getNextFrame();
    return fi.image;
  }
}