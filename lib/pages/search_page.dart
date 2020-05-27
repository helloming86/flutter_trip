import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/dao/search_dao.dart';
import 'package:trip/model/search_model.dart';
import 'package:trip/widget/search_bar.dart';
import 'package:trip/widget/webview.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchURL;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchURL = URL, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _searchBar(),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                // ?. 它的意思是左边如果为空返回 null，否则返回右边的值。
                // A?.B 如果 A 等于 null，那么 A?.B 为 null 如果 A 不等于 null，那么 A?.B 等价于 A.B
                // ?? 它的意思是左边如果为空返回右边的值，否则不处理。
                // A??B 如果 A 等于 null，那么 A??B 为 B 如果 A 不等于 null，那么 A??B 为 A
                itemCount: searchModel?.data?.length ?? 0, //
                itemBuilder: (BuildContext context, int position) {
                  return _item(position);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTextChange(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchURL + text;
    SearchDao.fetch(url, text).then((value) {
      // 只有当输入内容与服务端返回内容一致时才渲染
      if (value.keyword == keyword) {
        setState(() {
          searchModel = value;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _searchBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 25),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  Widget _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem searchItem = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Webview(
              url: searchItem.url,
              title: '详情',
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: Text(
                    '${searchItem.word} ${searchItem.districtName ?? ''} ${searchItem.zoneName ?? ''}',
                  ),
                ),
                Container(
                  width: 300,
                  child: Text(
                    '${searchItem.price ?? ''} ${searchItem.type ?? ''}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
