import 'package:ezhyper/Base/network-mappers.dart';


class AddressListModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  List<Data> data;

  AddressListModel({this.status, this.code, this.msg, this.data});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    return AddressListModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  var id;
  var address;
  var longitude;
  var latitude;
  var defaultAddress;
  var descriptions;
  var user;
  CreateDates createDates;
  UpdateDates updateDates;

  Data(
      {this.id,
        this.address,
        this.longitude,
        this.latitude,
        this.defaultAddress,
        this.descriptions,
        this.user,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    defaultAddress = json['default_address'];
    descriptions = json['descriptions'];
    user = json['user'];
/*
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
*/
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['default_address'] = this.defaultAddress;
    data['descriptions'] = this.descriptions;
    data['user'] = this.user;
  /*  if (this.user != null) {
      data['user'] = this.user.toJson();
    }*/
    if (this.createDates != null) {
      data['create_dates'] = this.createDates.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates.toJson();
    }
    return data;
  }
}


class CreateDates {
  String createdAtHuman;

  CreateDates({this.createdAtHuman});

  CreateDates.fromJson(Map<String, dynamic> json) {
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at_human'] = this.createdAtHuman;
    return data;
  }
}

class UpdateDates {
  String updatedAtHuman;

  UpdateDates({this.updatedAtHuman});

  UpdateDates.fromJson(Map<String, dynamic> json) {
    updatedAtHuman = json['updated_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at_human'] = this.updatedAtHuman;
    return data;
  }
}