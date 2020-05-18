import 'package:trip/model/common/common_model.dart';
import 'package:trip/model/common/config_model.dart';
import 'package:trip/model/common/grid_nav_model.dart';
import 'package:trip/model/common/sales_box_model.dart';

class HomeModel {
  ConfigModel config;
  List<CommonModel> bannerList;
  List<CommonModel> localNavList;
  GridNavModel gridNav;
  List<CommonModel> subNavList;
  SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList: subNavList,
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}
