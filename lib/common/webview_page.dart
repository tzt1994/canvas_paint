import 'package:canvas_paint/common/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Descriptions:
/// User: tangzhentao
/// Date: 2:24 下午 2021/8/31
///

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String _title = '';
  int _progress = 0;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cpAppBar(
        context,
        title: _title,
        bottom: _progress == 100 ? null : PreferredSize(
            child: LinearProgressIndicator(
              value: _progress / 100,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            preferredSize: Size.fromHeight(2.w)
        )
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (c) => _controller = c,
        onPageFinished: (url) {
          _controller?.evaluateJavascript("document.title").then((result) {
            setState(() {
              _title = result;
            });
          });
        },
        onProgress: (value) { setState(() {
          _progress = value;
        });},
      ),
    );
  }
}