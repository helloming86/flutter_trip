import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/model/common/grid_nav_model.dart';

class GridNav extends StatelessWidget{
  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, @required this.gridNavModel, this.name = 'nicky'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('GridNav');
  }

}