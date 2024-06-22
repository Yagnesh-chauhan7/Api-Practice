import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:postman_api_test/PostmanTestModel.dart';

class Distributorandretailordetailpage extends StatefulWidget {
  const Distributorandretailordetailpage({super.key});

  @override
  State<Distributorandretailordetailpage> createState() =>
      _DistributorandretailordetailpageState();
}

class _DistributorandretailordetailpageState
    extends State<Distributorandretailordetailpage> {
  var type = "Distributor";

  // var api = "http://128.199.98.121/admin/Api/add_distributor";
  var api = "http://testing.colorsoul.co/admin/Api/add_distributor";
  TextEditingController BussNameController = TextEditingController();
  TextEditingController BussTypeController = TextEditingController();
  TextEditingController BrandController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController StateController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController RegionController = TextEditingController();
  TextEditingController AreaController = TextEditingController();
  TextEditingController BankNameController = TextEditingController();
  TextEditingController GSTController = TextEditingController();
  TextEditingController PincodeController = TextEditingController();
  TextEditingController MobileController = TextEditingController();
  TextEditingController PersonNameController = TextEditingController();

  Future<void> CreateNewDataFromData(Datum newData) async {
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "4ccda7514adc0f13595a585205fb9761"
    };

    var request = http.MultipartRequest('POST', Uri.parse(api));
    request.headers.addAll(headers);
    request.fields['id'] = newData.id;
    request.fields['type'] = newData.type;
    request.fields['business_name'] = newData.businessName;
    request.fields['business_type'] = newData.businessType;
    request.fields['gst_no'] = newData.gstNo;
    request.fields['address'] = newData.address;
    request.fields['pincode'] = newData.pincode;
    request.fields['name'] = newData.name;
    request.fields['mobile'] = newData.mobile;
    request.fields['state'] = newData.state ?? '';
    request.fields['city'] = newData.city ?? '';
    request.fields['region_id'] = newData.regionId;
    request.fields['area_id'] = newData.areaId;
    request.fields['app_pk'] = newData.appPk;
    request.fields['image'] = newData.image ?? '';
    request.fields['bank_account_id'] = newData.bankAccountId;
    request.fields['isApproved'] = newData.isApproved;
    request.fields['open_time'] = newData.openTime;
    request.fields['close_time'] = newData.closeTime;
    request.fields['parent_id'] = newData.parentId;
    request.fields['is_async'] = newData.isAsync;
    request.fields['brands'] = newData.brands ?? '';
    request.fields['is_delete'] = newData.isDelete;

    // var test = {"key":newData.brands};
    // print(test);
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    var resJson = jsonDecode(responseData);

    // print(resJson['msg']);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: resJson['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xAE111111),
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(resJson['msg']);
    } else {
      print("User Not Crated1......");
    }
  }

  Future<void> CreateNewData(Datum newData) async {
    try {
      var url = Uri.parse(api);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '4ccda7514adc0f13595a585205fb9761'
        },
        body: jsonEncode(newData.toJson()),
      );
      print(response.body);
      print(response.statusCode);
      print(newData.bankAccountId);
      print(jsonEncode(newData.toJson()));

      if (response.statusCode == 201) {
        print("New User Created.....");
      } else {
        print("User Not Crated1......");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "ADD DETAIL DISTRIBUTOR AND RETAILER",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          type = "Distributor";
                          setState(() {});
                        },
                        child: Container(
                          color: type == "Distributor"
                              ? Colors.black
                              : Color(0x35000000),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "DISTRIBUTOR",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: type == "Distributor"
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          type = "Retailer";
                          setState(() {});
                        },
                        child: Container(
                          color: type == "Retailer"
                              ? Colors.black
                              : Color(0x35000000),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "RETAILER",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: type == "Retailer"
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: const Color(0x12000000)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.camera_alt), Text("Take Photo")],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Distributor Business Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: BussNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Business Type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: BussTypeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Select Brand",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: BrandController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: AddressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "State",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: StateController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: CityController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Region",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: RegionController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Area",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: AreaController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Bank Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: BankNameController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "GST No.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: GSTController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Pin Code",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: PincodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Person Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: PersonNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Mobile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: MobileController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                    color: Colors.black,
                    minWidth: double.maxFinite,
                    height: 50,
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      // print(BussNameController.text);
                      // print(BussTypeController.text);
                      // print(GSTController.text);
                      // print(AddressController.text);
                      // print(PincodeController.text);
                      // print(PersonNameController.text);
                      // print(MobileController.text);
                      // print(RegionController.text);
                      // print(AreaController.text);
                      // print(BankNameController.text);
                      // print(StateController.text);
                      // print(CityController.text);
                      // print(type);
                      var newData = Datum(
                        id: "6000",
                        type: type,
                        businessName: BussNameController.text,
                        businessType: BussTypeController.text,
                        gstNo: GSTController.text,
                        address: AddressController.text,
                        pincode: PincodeController.text,
                        name: PersonNameController.text,
                        mobile: MobileController.text,
                        state: StateController.text,
                        city: CityController.text,
                        regionId: RegionController.text,
                        areaId: AreaController.text,
                        appPk: 1.toString(),
                        image: "",
                        bankAccountId: BankNameController.text,
                        isApproved: 0.toString(),
                        openTime: "00:00",
                        closeTime: "00:00",
                        parentId: 0.toString(),
                        isAsync: 0.toString(),
                        brands: BrandController.text,
                        isDelete: 0.toString(),
                      );

                      // await CreateNewData(newData);
                      await CreateNewDataFromData(newData);
                    })
              ],
            ),
          ),
        ));
  }
}
