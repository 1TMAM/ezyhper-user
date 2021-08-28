import 'package:ezhyper/fileExport.dart';

class WalletModel extends BaseMappable {
  bool status;
  int code;
  String msg;
  List<Data> data;

  WalletModel({this.status, this.code, this.msg, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
    return WalletModel(status: status,code: code,msg: msg,data: data);
  }
}

class Data {
  var id;
  var cost;
  var remainBalance;
  var orderNum;
  var userId;
  User user;
  CreateDates createDates;
  UpdateDates updateDates;

  Data(
      {this.id,
        this.cost,
        this.remainBalance,
        this.orderNum,
        this.userId,
        this.user,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    remainBalance = json['remain_balance'];
    orderNum = json['order_num'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    data['cost'] = this.cost;
    data['remain_balance'] = this.remainBalance;
    data['order_num'] = this.orderNum;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates.toJson();
    }
    return data;
  }
}

class User {
  var id;
  var name;
  var email;
  var mobile;
  var birthDate;
  var iban;
  var bank;
  var block;
  var city;
  var status;
  var totalRate;
  var walletBalance;
  var iqamaExpirationDate;
  var iqamaPhoto;
  var deliveryPhoto;
  var driverLicence;
  var carLicence;
  var carFrontPhoto;
  var carBackPhoto;
  CreateDates createDates;
  UpdateDates updateDates;

  User(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.birthDate,
        this.iban,
        this.bank,
        this.block,
        this.city,
        this.status,
        this.totalRate,
        this.walletBalance,
        this.iqamaExpirationDate,
        this.iqamaPhoto,
        this.deliveryPhoto,
        this.driverLicence,
        this.carLicence,
        this.carFrontPhoto,
        this.carBackPhoto,
        this.createDates,
        this.updateDates});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    birthDate = json['birth_date'];
    iban = json['iban'];
    bank = json['bank'];
    block = json['block'];
    city = json['city'];
    status = json['status'];
    totalRate = json['total_rate'];
    walletBalance = json['wallet_balance'];
    iqamaExpirationDate = json['Iqama_expiration_date'];
    iqamaPhoto = json['iqama_photo'];
    deliveryPhoto = json['delivery_photo'];
    driverLicence = json['driver_licence'];
    carLicence = json['car_licence'];
    carFrontPhoto = json['car_front_photo'];
    carBackPhoto = json['car_back_photo'];
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
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['birth_date'] = this.birthDate;
    data['iban'] = this.iban;
    data['bank'] = this.bank;
    data['block'] = this.block;
    data['city'] = this.city;
    data['status'] = this.status;
    data['total_rate'] = this.totalRate;
    data['wallet_balance'] = this.walletBalance;
    data['Iqama_expiration_date'] = this.iqamaExpirationDate;
    data['iqama_photo'] = this.iqamaPhoto;
    data['delivery_photo'] = this.deliveryPhoto;
    data['driver_licence'] = this.driverLicence;
    data['car_licence'] = this.carLicence;
    data['car_front_photo'] = this.carFrontPhoto;
    data['car_back_photo'] = this.carBackPhoto;
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