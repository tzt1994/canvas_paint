import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Description:
///
/// @author tangzhentao
/// @time 11:28 AM 3/3/21

class ListWheelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListWheelPageState();
}

class _ListWheelPageState extends State<ListWheelPage> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('列表测试'),),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 500,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 100,
              diameterRatio: 3,
              useMagnifier: true,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 20,
                builder: (context, index) => ListTile(
                  leading: Text('测试item leading'),
                  title: Text('测试item 标题'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}