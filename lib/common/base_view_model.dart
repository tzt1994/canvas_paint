import 'package:flutter/widgets.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 10:47 AM 4/14/21
///

/// 页面状态
enum PageState {Loading, Success, Error, Empty}

class BaseViewModel extends ChangeNotifier {
  /// 是否已经销毁，默认false
  bool _isDisposed = false;

  /// 页面状态，默认成功
  PageState _state = PageState.Success;
  PageState get state => _state;

  /// 更新页面状态
  /// [state] 页面状态
  /// [rebuild] 是否更新页面，默认更新
  setState(PageState state, {bool rebuild = true}) {
    _state = state;
    if (rebuild) notifyListeners();
  }

  /// 错误页面点击
  onErrorClick() {}
  /// 空页面点击
  onEmptyClick() {}

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}