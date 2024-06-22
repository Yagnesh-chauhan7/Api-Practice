import 'dart:convert';

// PostmanTestModel postmanTestModelFromJson(String str) => PostmanTestModel.fromJson(json.decode(str));
//
// String postmanTestModelToJson(PostmanTestModel data) => json.encode(data.toJson());

class PostmanTestModel {
  String st;
  String msg;
  String limit;
  int numberOfPage;
  String total;
  String page;
  List<Datum> data;

  PostmanTestModel({
    required this.st,
    required this.msg,
    required this.limit,
    required this.numberOfPage,
    required this.total,
    required this.page,
    required this.data,
  });

  factory PostmanTestModel.fromJson(Map<String, dynamic> json) => PostmanTestModel(
    st: json["st"],
    msg: json["msg"],
    limit: json["limit"],
    numberOfPage: json["number_of_page"],
    total: json["total"],
    page: json["page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))).toList(),
  );

  Map<String, dynamic> toJson() => {
    "st": st,
    "msg": msg,
    "limit": limit,
    "number_of_page": numberOfPage,
    "total": total,
    "page": page,
    "data": List<dynamic>.from(data.map((x) => x.toJson()).toList()),
  };
}

class Datum {
  String id;
  String type;
  String businessName;
  String businessType;
  String gstNo;
  String address;
  String pincode;
  String name;
  String mobile;
  String? state;
  String? city;
  String regionId;
  String areaId;
  String appPk;
  String? image;
  String bankAccountId;
  String isApproved;
  String openTime;
  String closeTime;
  String parentId;
  String isAsync;
  String? brands;
  String isDelete;

  Datum({
    required this.id,
    required this.type,
    required this.businessName,
    required this.businessType,
    required this.gstNo,
    required this.address,
    required this.pincode,
    required this.name,
    required this.mobile,
     this.state,
     this.city,
    required this.regionId,
    required this.areaId,
    required this.appPk,
     this.image,
    required this.bankAccountId,
    required this.isApproved,
    required this.openTime,
    required this.closeTime,
    required this.parentId,
    required this.isAsync,
     this.brands,
    required this.isDelete,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "0",
    type: json["type"]!,
    businessName: json["business_name"] ?? "0",
    businessType: json["business_type"] ?? "0",
    gstNo: json["gst_no"] ?? "0",
    address: json["address"] ?? "0",
    pincode: json["pincode"] ?? "0",
    name: json["name"] ?? "0",
    mobile: json["mobile"] ?? "0",
    state: json["state"]??"0",
    city: json["city"]??"0",
    regionId: json["region_id"] ?? "0",
    areaId: json["area_id"] ?? "0",
    appPk: json["app_pk"] ?? "0",
    image: json["image"]??"0",
    bankAccountId: json["bank_account_id"] ?? "1",
    isApproved: json["isApproved"] ?? "0",
    openTime: json["open_time"]!,
    closeTime: json["close_time"]!,
    parentId: json["parent_id"] ?? "0",
    isAsync: json["is_async"] ?? "0",
    brands: json["brands"] ?? "0",
    isDelete: json["is_delete"] ?? "0",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "business_name": businessName,
    "business_type": businessType,
    "gst_no": gstNo,
    "address": address,
    "pincode": pincode,
    "name": name,
    "mobile": mobile,
    "state": state??"0",
    "city": city??"0",
    "region_id": regionId,
    "area_id": areaId,
    "app_pk": appPk,
    "image": image??"0",
    "bank_account_id": bankAccountId,
    "isApproved": isApproved,
    "open_time": openTime,
    "close_time": closeTime,
    "parent_id": parentId,
    "is_async": isAsync,
    "brands": brands??"0",
    "is_delete": isDelete,
  };
}

// enum Time {
//   THE_0000
// }

// final timeValues = EnumValues({
//   "00:00": Time.THE_0000
// });

// enum Type {
//   DISTRIBUTOR,
//   RETAILER
// }
//
// final typeValues = EnumValues({
//   "Distributor": Type.DISTRIBUTOR,
//   "Retailer": Type.RETAILER
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
