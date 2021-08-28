import 'package:ezhyper/Base/network-mappers.dart';

class BrandModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  Data data;

  BrandModel({this.status, this.code, this.msg, this.data});

  BrandModel.fromJson(Map<String, dynamic> json) {
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
    return BrandModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  List<BrandData> brand_data;
  Meta meta;

  Data({this.brand_data, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      brand_data = new List<BrandData>();
      json['data'].forEach((v) {
        brand_data.add(new BrandData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brand_data != null) {
      data['data'] = this.brand_data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class BrandData {
  int id;
  String name;
  int active;
  String nameAr;
  String nameEn;
  CreateDates createDates;
  UpdateDates updateDates;

  BrandData(
      {this.id,
        this.name,
        this.active,
        this.nameAr,
        this.nameEn,
        this.createDates,
        this.updateDates});

  BrandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
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
    data['active'] = this.active;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
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

class Meta {
  int total;
  int currentPage;
  int lastPage;

  Meta({this.total, this.currentPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currentPage'] = this.currentPage;
    data['lastPage'] = this.lastPage;
    return data;
  }
}