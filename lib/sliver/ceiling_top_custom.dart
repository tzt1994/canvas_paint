import 'package:flutter/material.dart';

/// Description: 吸顶内容不是tabbar+ tabbarview
///
/// @author tangzhentao 
/// @date 2020/4/6

class CeilingTopCustomPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CeilingTopCustomPageState();
  }

}

class CeilingTopCustomPageState extends State<CeilingTopCustomPage> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 230,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('复仇者联盟'),
              background: Image.network(
                'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 60,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Text('item$index'),
              );
            }, childCount: 120),
          )
        ],
      ),
    );
  }

}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  double height;

  StickyHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}