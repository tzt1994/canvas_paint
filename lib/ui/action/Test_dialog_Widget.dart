import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Description:
///
/// @author tangzhentao
/// @time 4:47 PM 3/1/21

class TestDialogWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestDialogWidgetState();
}

class _TestDialogWidgetState extends State<TestDialogWidget> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('弹窗出现');
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _editingController,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: '请输入'
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('关闭'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('弹窗消失');
    _editingController.dispose();
  }
}