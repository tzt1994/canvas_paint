import 'package:flutter/material.dart';

/// Description:
///
/// @author tangzhentao 
/// @date 2020/8/3 

class PaintPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PaintPageState();

}

class PaintPageState extends State<PaintPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('paint'),
    );
  }

}