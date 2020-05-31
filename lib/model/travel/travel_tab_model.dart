class TravelTabModel {
  // final 声明不可变变量，编译时不确定，运行时才确定
  // const 声明不可变变量，编译时就确定了
  // static 声明类级别的变量和函数（非实例）,声明类的成员变量，使得多个相同类型的类对象共享同一个成员变量的实例
  // factory 如果一个构造函数并不总是返回一个新的对象，则使用 factory 来定义 这个构造函数。例如，一个工厂构造函数 可能从缓存中获取一个实例并返回，或者 返回一个子类型的实例。
  Map params; // 请求参数
  String url; // 请求地址
  List<TravelTab> tabs; // 标签列表

  TravelTabModel({this.url, this.tabs});

  //思考，为什么这里的fromJson不能是工厂方法
  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    params = json['params'];
    if (json['tabs'] != null) {
      tabs = List<TravelTab>();
      json['tabs'].forEach((v) {
        tabs.add(TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// 单个TAB标签的Model，有两个成员变量 labelName 和 groupChannelCode
class TravelTab {
  final String labelName;
  final String groupChannelCode;

  // 标准构造方法
  TravelTab({this.labelName, this.groupChannelCode});

  // 命名构造方法 TravelTab.fromJson，将Map拆解成单条数据
  factory TravelTab.fromJson(Map<String, dynamic> json) {
    return TravelTab(
      labelName: json['labelName'],
      groupChannelCode: json['groupChannelCode'],
    );
  }

  // 成员方法toJson，将单条数据组装成Map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
