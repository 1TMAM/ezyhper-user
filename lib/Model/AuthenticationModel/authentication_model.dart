import 'package:ezhyper/fileExport.dart';

class AuthenticationModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  Data data;

  AuthenticationModel({this.status, this.code, this.msg, this.data});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return AuthenticationModel(status: status,code: code,msg: msg,data: data);
  }
}

class Data {
  var id;
  var name;
  var phone;
  var email;
  var address;
  var longitude;
  var latitude;
  var promoCode;
  var broker;
  var block;
  var type;
  var walletBalance;
  var rewardPoint;
  String firebaseToken;
  String accessToken;

  Data(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.address,
        this.longitude,
        this.latitude,
        this.promoCode,
        this.broker,
        this.block,
        this.type,
        this.walletBalance,
        this.rewardPoint,
        this.firebaseToken,
        this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    promoCode = json['promo_code'];
    broker = json['broker'];
    block = json['block'];
    type = json['type'];
    walletBalance = json['wallet_balance'];
    rewardPoint = json['reward_point'];
    firebaseToken = json['firebase_token'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['promo_code'] = this.promoCode;
    data['broker'] = this.broker;
    data['block'] = this.block;
    data['type'] = this.type;
    data['wallet_balance'] = this.walletBalance;
    data['reward_point'] = this.rewardPoint;
    data['firebase_token'] = this.firebaseToken;
    data['access_token'] = this.accessToken;
    return data;
  }
}