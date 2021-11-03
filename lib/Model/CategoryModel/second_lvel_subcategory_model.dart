import 'package:ezhyper/Base/network-mappers.dart';

class SecondLevelSubcategoryModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  List<Data> data;

  SecondLevelSubcategoryModel({this.status, this.code, this.msg, this.data});

  SecondLevelSubcategoryModel.fromJson(Map<String, dynamic> json) {
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
    return SecondLevelSubcategoryModel(status: status,code: code,msg: msg,data: data);
  }
}

class Data {
  int id;
  String name;
  String cover;
  Category category;
  CreateDates createDates;
  UpdateDates updateDates;

  Data(
      {this.id,
        this.name,
        this.cover,
        this.category,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    category = json['category'];
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
    data['cover'] = this.cover;
    data['category'] = this.category;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates.toJson();
    }
    return data;
  }
}
class Category {
  var id;
  var name;
  var cover;
  List<SubCategory> subCategory;
  CreateDates createDates;
  UpdateDates updateDates;

  Category(
      {this.id,
        this.name,
        this.cover,
        this.subCategory,
        this.createDates,
        this.updateDates});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    if (json['sub_category'] != null) {
      subCategory = new List<SubCategory>();
      json['sub_category'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
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
    data['cover'] = this.cover;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory.map((v) => v.toJson()).toList();
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
class SubCategory {
  var id;
  var name;
  var cover;
  Category category;
  CreateDates createDates;
  UpdateDates updateDates;

  SubCategory(
      {this.id,
        this.name,
        this.cover,
        this.category,
        this.createDates,
        this.updateDates});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    data['cover'] = this.cover;
    if (this.category != null) {
      data['category'] = this.category.toJson();
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

