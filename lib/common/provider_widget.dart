import 'package:canvas_paint/common/base_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 10:46 AM 4/14/21
///

class ProviderWidget<T extends BaseViewModel> extends StatefulWidget {
  late T model;
  Function(T)? onReady;
  late Widget Function(BuildContext context, T value, Widget? child) builder;
  late Widget? child;
  // 是否内部自动处理State状态
  late bool autoState;

  ProviderWidget({
    required Key? key,
    required this.model,
    required this.builder,
    this.child,
    this.onReady,
    this.autoState = true,
  }):super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends BaseViewModel> extends State<ProviderWidget<T>> {
  late Consumer<T> content;

  @override
  void initState() {
    super.initState();
    content = Consumer<T>(builder: widget.builder, child: widget.child,);
    widget.onReady?.call(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => widget.model,
      child: widget.autoState ?
      Stack(
        children: [
          content,
          Consumer<T>(builder: (_, data, child) => _getStatePage(data.state))
        ],
      ) : content,
    );
  }

  /// 根据页面状态获取对应的页面
  Widget _getStatePage(PageState state) => Offstage(
    offstage: state == PageState.Success,
    child: state == PageState.Loading
        ? Center(child: Text('loading'),)
        : (state == PageState.Empty
        ? Center(child: Text('Empty'),)
        : (state == PageState.Error) ? Center(child: Text('Error'),) : Container()),
  );
}
