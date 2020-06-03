import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/dao/travel_tab_dao.dart';
import 'package:trip/model/travel/travel_tab_model.dart';
import 'package:trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

// SingleTickerProviderStateMixin 和 TickerProviderStateMixin 的区别
// TickerProviderStateMixin适用于多AnimationController的情况
// 本例，initState中 多次调用了 TabController()
class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(
      length: 0,
      // 使用vsync ，需要with SingleTickerProviderStateMixin
      vsync: this,
    );
    TravelTabDao.fetch().then((model) {
      _controller = TabController(
        length: model.tabs.length,
        vsync: this,
      );
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) => print(e));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // TabBar 和 TabBarView 配合使用
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((tab) {
                return Tab(text: tab.labelName);
              }).toList(),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((tab) {
                return TravelTabPage(
                  travelUrl: travelTabModel.url,
                  // 注意，这里要有params，这是由获取旅拍页面内容json的接口决定的
                  params: travelTabModel.params,
                  groupChannelCode: tab.groupChannelCode,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
