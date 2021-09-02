import 'package:flutter/material.dart';

import 'bar_chart.dart';

/// Description: 自定义barchart
///
/// @author tangzhentao 
/// @date 2020/4/6 

class BarChartScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BarChartScrollState();
  }

}

class BarChartScrollState extends State<BarChartScroll> {
  List<BarEntry> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('柱状图', style: TextStyle(color: Colors.white),),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BarChart(
            width: double.infinity,
            height: 300,
            data: list,
          ),
          Container(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: double.infinity,
                  width: 60,
                  child: Column(
                    children: <Widget>[
                      Expanded(flex: 1, child: Container(),),
                      Container(
                        height: 60,
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Container(),),
                            Container(
                              width: 40,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      Container(height: 1, color: Colors.black87,),
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20),
                        child: Text('00：00', style: TextStyle(fontSize: 10),),
                      )
                    ],
                  ),
                );
              },
              itemCount: 40,
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                list.add(BarEntry(x: '123', y: 22.0));
              });
            },
            child: Text('添加'),
          )
        ],
      )
    );
  }

}