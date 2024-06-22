import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:postman_api_test/ApiCallingProvider.dart';
import 'package:postman_api_test/DistributorAndRetailorDetailPage.dart';
import 'package:postman_api_test/PostmanTestModel.dart';
import 'package:postman_api_test/SqflitForApi.dart';
import 'package:postman_api_test/main.dart';
import 'package:provider/provider.dart';

class Usingproviderapicall extends StatefulWidget {
  const Usingproviderapicall({super.key});

  @override
  State<Usingproviderapicall> createState() => _UsingproviderapicallState();
}

class _UsingproviderapicallState extends State<Usingproviderapicall> {
  var type = "distributor";
  ScrollController scrollController = ScrollController();
  List<Datum> listDistributor = [];
  List<Datum> listRetailer = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var provider = Provider.of<apiProvider>(context, listen: false);
    provider.callApi();

    provider.addListener((){
      if(!provider.spinerLoad){
        fetchData();
      }
    });
    fetchData();

    setState(() { });
    // scrollController.addListener((){
    //   if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
    //     provider.callApi();
    //   }
    // });
  }

  Future<void> fetchData() async {
    listDistributor =  await ApiLocalDB().AllDataRetriveForDistributor() as List<Datum>;
    listRetailer = await ApiLocalDB().AllDataRetriveForRetailer() as List<Datum>;

    print(listDistributor.length);
    print(listRetailer.length);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text("DISTRIBUTOR OR RETAILER LIST"),
      ),
      body: Consumer<apiProvider>(
        builder: (context, value, child) {
          return Column(

            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          type = "distributor";
                          setState(() {});
                        },
                        child: Container(
                          color: type == "distributor"
                              ? Colors.black
                              : Color(0x35000000),
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "DISTRIBUTOR",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: type == "distributor"
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
                          type = "retailer";
                          setState(() {});
                        },
                        child: Container(
                          color: type == "retailer"
                              ? Colors.black
                              : Color(0x35000000),
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "RETAILER",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: type == "retailer"
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
              ),
              // Expanded(
              //   child: Stack(children: [
              //     ListView.builder(
              //
              //       controller: scrollController,
              //       itemCount: type == "distributor"
              //           ? value.DistributorList.length
              //           : value.RetailerList.length,
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Card(
              //             shape: const RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.zero),
              //             color: Colors.white,
              //             elevation: 5,
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(
              //                   vertical: 10.0, horizontal: 20),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     type == "distributor"
              //                         ? value.DistributorList[index]
              //                             .businessName
              //                         : value
              //                             .RetailerList[index].businessName,
              //                     style: TextStyle(
              //                         fontSize: 22,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Row(
              //                     crossAxisAlignment:
              //                         CrossAxisAlignment.start,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Row(
              //                         children: [
              //                           Icon(Icons.location_on_outlined),
              //                           Container(
              //                             width: 250,
              //                             child: Text(
              //                               type == "distributor"
              //                                   ? value
              //                                       .DistributorList[index]
              //                                       .address
              //                                   : value.RetailerList[index]
              //                                       .address,
              //                               textWidthBasis:
              //                                   TextWidthBasis.parent,
              //                               style: TextStyle(
              //                                   fontSize: 18,
              //                                   fontWeight:
              //                                       FontWeight.w300),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       Image.asset(
              //                         "assets/image/three_dot.png",
              //                         height: 20,
              //                         width: 20,
              //                       )
              //                     ],
              //                   ),
              //                   Row(
              //                     children: [
              //                       Text(
              //                         "Status:-",
              //                         style: TextStyle(
              //                             fontSize: 14,
              //                             color: Colors.black),
              //                       ),
              //                       Text(
              //                         type == "distributor"
              //                             ? value.DistributorList[index]
              //                                         .isApproved ==
              //                                     0
              //                                 ? "NON-Active"
              //                                 : "Active"
              //                             : value.RetailerList[index]
              //                                         .isApproved ==
              //                                     0
              //                                 ? "NON-Active"
              //                                 : "Active",
              //                         style: TextStyle(
              //                             fontSize: 14,
              //                             color: Color(0xff1df19f)),
              //                       ),
              //                     ],
              //                   ),
              //                   Text(
              //                     "ID:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index].id
              //                             : value.RetailerList[index].id),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Bussiness Type:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .businessType
              //                             : value.RetailerList[index]
              //                                 .businessType),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "GST no.:-" +
              //                         (type == "distributor"
              //                             ? value
              //                                 .DistributorList[index].gstNo
              //                             : value
              //                                 .RetailerList[index].gstNo),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "PinCode:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .pincode
              //                             : value
              //                                 .RetailerList[index].pincode),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Name:-" +
              //                         (type == "distributor"
              //                             ? value
              //                                 .DistributorList[index].name
              //                             : value.RetailerList[index].name),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Mobile:-" +
              //                         (type == "distributor"
              //                             ? value
              //                                 .DistributorList[index].mobile
              //                             : value
              //                                 .RetailerList[index].mobile),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "State.:-" +
              //                         (type == "distributor"
              //                                 ? value.DistributorList[index]
              //                                     .state
              //                                 : value.RetailerList[index]
              //                                     .state)
              //                             .toString(),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "City:-" +
              //                         (type == "distributor"
              //                                 ? value.DistributorList[index]
              //                                     .city
              //                                 : value
              //                                     .RetailerList[index].city)
              //                             .toString(),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Regin ID:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .regionId
              //                             : value.RetailerList[index]
              //                                 .regionId),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Area Id:-" +
              //                         (type == "distributor"
              //                             ? value
              //                                 .DistributorList[index].areaId
              //                             : value
              //                                 .RetailerList[index].areaId),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "App pk.:-" +
              //                         (type == "distributor"
              //                             ? value
              //                                 .DistributorList[index].appPk
              //                             : value
              //                                 .RetailerList[index].appPk),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Image:-" +
              //                         (type == "distributor"
              //                                 ? value.DistributorList[index]
              //                                     .image
              //                                 : value.RetailerList[index]
              //                                     .image)
              //                             .toString(),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Bank account ID:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .bankAccountId
              //                             : value.RetailerList[index]
              //                                 .bankAccountId),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "isApproved:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .isApproved
              //                             : value.RetailerList[index]
              //                                 .isApproved),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "open Time.:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .openTime
              //                             : value.RetailerList[index]
              //                                 .openTime),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "close Time:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .closeTime
              //                             : value.RetailerList[index]
              //                                 .closeTime),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Parent ID:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .parentId
              //                             : value.RetailerList[index]
              //                                 .parentId),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "is async:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .isAsync
              //                             : value
              //                                 .RetailerList[index].isAsync),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "Brand.:-" +
              //                         (type == "distributor"
              //                                 ? value.DistributorList[index]
              //                                     .brands
              //                                 : value.RetailerList[index]
              //                                     .brands)
              //                             .toString(),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     "is delete:-" +
              //                         (type == "distributor"
              //                             ? value.DistributorList[index]
              //                                 .isDelete
              //                             : value.RetailerList[index]
              //                                 .isDelete),
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //     Positioned(
              //       bottom: 15,
              //       right: 20,
              //       child: InkWell(
              //         onTap: () {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (_) =>
              //                   Distributorandretailordetailpage()));
              //         },
              //         child: Container(
              //           color: Colors.black,
              //           child: Padding(
              //             padding: const EdgeInsets.all(10.0),
              //             child: Icon(
              //               Icons.add,
              //               color: Colors.white,
              //               size: 30,
              //             ),
              //           ),
              //         ),
              //       ),
              //     )
              //   ]),
              // ),
              value.spinerLoad? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ Container(
                      height: 100,
                      width: 100,
                      child: Card(
                        color: Colors.white,
                        elevation: 7,
                        child: SpinKitCircle(
                          color: Colors.black,
                          size: 80.0, ),
                      ),
                    )],))
                  :Expanded(

                child: Stack(children: [

                  ListView.builder(

                    controller: scrollController,
                    itemCount: type == "distributor"
                        ? listDistributor.length
                        : listRetailer.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          color: Colors.white,
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type == "distributor"
                                      ? listDistributor[index]
                                      .businessName
                                      : listRetailer[index].businessName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined),
                                        Container(
                                          width: 250,
                                          child: Text(
                                            type == "distributor"
                                                ? listDistributor[index]
                                                .address
                                                : listRetailer[index]
                                                .address,
                                            textWidthBasis:
                                            TextWidthBasis.parent,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      "assets/image/three_dot.png",
                                      height: 20,
                                      width: 20,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Status:-",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      type == "distributor"
                                          ? listDistributor[index]
                                          .isApproved ==
                                          0
                                          ? "NON-Active"
                                          : "Active"
                                          : listRetailer[index]
                                          .isApproved ==
                                          0
                                          ? "NON-Active"
                                          : "Active",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff1df19f)),
                                    ),
                                  ],
                                ),
                                Text(
                                  "ID:-" +
                                      (type == "distributor"
                                          ? listDistributor[index].id
                                          : listRetailer[index].id),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Bussiness Type:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .businessType
                                          : listRetailer[index]
                                          .businessType),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "GST no.:-" +
                                      (type == "distributor"
                                          ? listDistributor[index].gstNo
                                          : listRetailer[index].gstNo),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "PinCode:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .pincode
                                          : listRetailer[index].pincode),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Name:-" +
                                      (type == "distributor"
                                          ? listDistributor[index].name
                                          : listRetailer[index].name),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Mobile:-" +
                                      (type == "distributor"
                                          ? listDistributor[index].mobile
                                          : listRetailer[index].mobile),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "State.:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .state
                                          : listRetailer[index]
                                          .state)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "City:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .city
                                          : listRetailer[index].city)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Regin ID:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .regionId
                                          : listRetailer[index]
                                          .regionId),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Area Id:-" +
                                      (type == "distributor"
                                          ? listDistributor[index].areaId
                                          : listRetailer[index].areaId),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "App pk.:-" +
                                      (type == "distributor"
                                          ? listDistributor[index].appPk
                                          : listRetailer[index].appPk),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Image:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .image
                                          : listRetailer[index]
                                          .image)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Bank account ID:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .bankAccountId
                                          : listRetailer[index]
                                          .bankAccountId),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "isApproved:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .isApproved
                                          : listRetailer[index]
                                          .isApproved),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "open Time.:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .openTime
                                          : listRetailer[index]
                                          .openTime),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "close Time:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .closeTime
                                          : listRetailer[index]
                                          .closeTime),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Parent ID:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .parentId
                                          : listRetailer[index]
                                          .parentId),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "is async:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .isAsync
                                          : listRetailer[index].isAsync),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Brand.:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .brands
                                          : listRetailer[index]
                                          .brands)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "is delete:-" +
                                      (type == "distributor"
                                          ? listDistributor[index]
                                          .isDelete
                                          : listRetailer[index]
                                          .isDelete),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 15,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                Distributorandretailordetailpage()));
                      },
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
