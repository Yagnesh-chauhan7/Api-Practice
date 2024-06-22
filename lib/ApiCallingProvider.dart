import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:postman_api_test/PostmanTestModel.dart';
import 'package:postman_api_test/SqflitForApi.dart';

class apiProvider extends ChangeNotifier {
  var api =
      "http://testing.colorsoul.co/admin/Api/get_retailer_distributor_master";
  List<Datum> DistributorList = [];
  List<Datum> RetailerList = [];
  var count = 1;
  bool isLoading = false;
  bool spinerLoad = false;

  void callApi() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    var url = Uri.parse(api + "/$count");
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': '4ccda7514adc0f13595a585205fb9761'
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      spinerLoad = true;
      var data = jsonDecode(response.body);

      var postmanData = PostmanTestModel.fromJson(data);

      for (var i = 0; i < postmanData.data.length; i++) {
        if (postmanData.data[i].type == "Distributor") {
          DistributorList.add(postmanData.data[i]);
          var data = Datum(
              id: postmanData.data[i].id,
              type: postmanData.data[i].type,
              businessName: postmanData.data[i].businessType,
              businessType: postmanData.data[i].businessName,
              gstNo: postmanData.data[i].gstNo,
              address: postmanData.data[i].address,
              pincode: postmanData.data[i].pincode,
              name: postmanData.data[i].name,
              mobile: postmanData.data[i].mobile,
              regionId: postmanData.data[i].regionId,
              areaId: postmanData.data[i].areaId,
              appPk: postmanData.data[i].appPk,
              bankAccountId: postmanData.data[i].bankAccountId,
              isApproved: postmanData.data[i].isApproved,
              openTime: postmanData.data[i].openTime,
              closeTime: postmanData.data[i].closeTime,
              parentId: postmanData.data[i].parentId,
              isAsync: postmanData.data[i].isAsync,
              isDelete: postmanData.data[i].isDelete,
              brands: postmanData.data[i].brands,
              image: postmanData.data[i].image,
              city: postmanData.data[i].city,
              state: postmanData.data[i].state);

          await ApiLocalDB().InsertDataForDistibutor(data);
        } else {
          RetailerList.add(postmanData.data[i]);

          var data = Datum(
              id: postmanData.data[i].id,
              type: postmanData.data[i].type,
              businessName: postmanData.data[i].businessType,
              businessType: postmanData.data[i].businessName,
              gstNo: postmanData.data[i].gstNo,
              address: postmanData.data[i].address,
              pincode: postmanData.data[i].pincode,
              name: postmanData.data[i].name,
              mobile: postmanData.data[i].mobile,
              regionId: postmanData.data[i].regionId,
              areaId: postmanData.data[i].areaId,
              appPk: postmanData.data[i].appPk,
              bankAccountId: postmanData.data[i].bankAccountId,
              isApproved: postmanData.data[i].isApproved,
              openTime: postmanData.data[i].openTime,
              closeTime: postmanData.data[i].closeTime,
              parentId: postmanData.data[i].parentId,
              isAsync: postmanData.data[i].isAsync,
              isDelete: postmanData.data[i].isDelete,
              brands: postmanData.data[i].brands,
              image: postmanData.data[i].image,
              city: postmanData.data[i].city,
              state: postmanData.data[i].state);

          await ApiLocalDB().InsertDataForRetailer(data);
        }

        // callApi(count);
      }
      if (count < postmanData.numberOfPage) {
        count++;
        print("data added");
        isLoading = false;
        callApi();
        notifyListeners();
      } else {
        print("data full loaded..");
        isLoading = true;
        spinerLoad = false;


        notifyListeners();
      }
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(
        msg: "Data Not Show",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.black26,
      );
      isLoading = false;
      notifyListeners();
    }
  }

}
