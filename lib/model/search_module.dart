class SearchModule {
  String keyword;
  Head head;
  List<Data> data;

  SearchModule({this.head, this.data});

  SearchModule.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'] != null ? json['keyword'] : null;
    head = json['head'] != null ? new Head.fromJson(json['head']) : null;
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keyword != null) {
      data['keyword'] = this.keyword;
    }
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Head {
  Null auth;
  String errcode;

  Head({this.auth, this.errcode});

  Head.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    errcode = json['errcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth'] = this.auth;
    data['errcode'] = this.errcode;
    return data;
  }
}

class Data {
  int id;
  String word;
  String type;
  String url;
  int lat;
  int lon;
  int cityId;
  int districtId;
  int productScore;
  String scoreDesc;
  int childProductScore;
  String childScoreDesc;
  int simNum;
  int luceneScore;
  int commentCount;
  int commentScore;
  int sales;
  int startScore;
  int parentDistrictId;
  int traveldays;
  String districtname;

  Data(
      {this.id,
      this.word,
      this.type,
      this.url,
      this.lat,
      this.lon,
      this.cityId,
      this.districtId,
      this.productScore,
      this.scoreDesc,
      this.childProductScore,
      this.childScoreDesc,
      this.simNum,
      this.luceneScore,
      this.commentCount,
      this.commentScore,
      this.sales,
      this.startScore,
      this.parentDistrictId,
      this.traveldays,
      this.districtname});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    type = json['type'];
    url = json['url'];
    lat = json['lat'];
    lon = json['lon'];
    cityId = json['cityId'];
    districtId = json['districtId'];
    productScore = json['productScore'];
    scoreDesc = json['scoreDesc'];
    childProductScore = json['childProductScore'];
    childScoreDesc = json['childScoreDesc'];
    simNum = json['simNum'];
    luceneScore = json['luceneScore'];
    commentCount = json['commentCount'];
    commentScore = json['commentScore'];
    sales = json['sales'];
    startScore = json['startScore'];
    parentDistrictId = json['parentDistrictId'];
    traveldays = json['traveldays'];
    districtname = json['districtname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['type'] = this.type;
    data['url'] = this.url;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['cityId'] = this.cityId;
    data['districtId'] = this.districtId;
    data['productScore'] = this.productScore;
    data['scoreDesc'] = this.scoreDesc;
    data['childProductScore'] = this.childProductScore;
    data['childScoreDesc'] = this.childScoreDesc;
    data['simNum'] = this.simNum;
    data['luceneScore'] = this.luceneScore;
    data['commentCount'] = this.commentCount;
    data['commentScore'] = this.commentScore;
    data['sales'] = this.sales;
    data['startScore'] = this.startScore;
    data['parentDistrictId'] = this.parentDistrictId;
    data['traveldays'] = this.traveldays;
    data['districtname'] = this.districtname;
    return data;
  }
}
