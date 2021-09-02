import 'package:flutter/material.dart';

/// Description: 吸顶
///
/// @author tangzhentao 
/// @date 2020/4/6

class CeilingTopNestedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CeilingTopNestedPageState();
  }

}

class CeilingTopNestedPageState extends State<CeilingTopNestedPage> with SingleTickerProviderStateMixin {
  late ScrollController _scrollViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
          body: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 220,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('复仇者联盟'),
                      background: Image.network(
                        'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: StickyTabBarDelegate(
                      child: TabBar(
                        labelColor: Colors.black,
                        controller: this._tabController,
                        tabs: <Widget>[
                          Tab(text: '资讯'),
                          Tab(text: '技术'),
                          Tab(text: '论坛'),
                        ],
                      )
                    ),
                  ),
                ];
              },
              body: TabBarView(controller: _tabController, children: [
                _buildListView("aaa:"),
                _buildListView("bbb:"),
                _buildListView("ccc:"),
              ]))),
    );
  }

  Widget _buildListView(String s){
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) =>Divider(color: Colors.grey,height: 1,),
        itemBuilder: (BuildContext context, int index) {
          return Container(color: Colors.white, child: ListTile(title: Text("$s第$index 个条目")));
        });
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}