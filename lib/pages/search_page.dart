import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/dao/search_dao.dart';
import 'package:trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: 'Halo',
            hint: '123',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
          InkWell(
            onTap: () {
              SearchDao.fetch(
                      'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=%E9%95%BF%E5%9F%8E')
                  .then((value) {
                setState(() {
                  showText = value.data[0].url;
                });
              });
            },
            child: Text(
              '验证Search接口',
            ),
          ),
          Text(showText),
        ],
      ),
    );
  }

  _onTextChange(String text) {}
}
