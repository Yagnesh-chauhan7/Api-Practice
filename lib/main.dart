import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:postman_api_test/ApiCallingProvider.dart';
import 'package:postman_api_test/DistributorAndRetailorDetailPage.dart';
import 'package:postman_api_test/PostmanTestModel.dart';
import 'package:http/http.dart' as http;
import 'package:postman_api_test/UsingProviderApiCall.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<apiProvider>(create: (context) => apiProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Usingproviderapicall(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var type = "distributor";
  late PostmanTestModel postmanTestModel;

  var api = "http://testing.colorsoul.co/admin/Api/get_retailer_distributor_master/1";
  List<PostmanTestModel> datalist = [];
  List<Datum> distributorList = [];
  List<Datum> RetailorList = [];

  Future<PostmanTestModel?> getData() async {
    var url = Uri.parse(api);
    try {
      final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'4ccda7514adc0f13595a585205fb9761'
      }
      );
      if (response.statusCode == 200) {
        print("code:-"+response.statusCode.toString());

        var data = jsonDecode(response.body);
         print("object");
         print(data);
        // var parsed = data['data'];

         postmanTestModel=PostmanTestModel.fromJson(data);


          print("object");

        await getDistributorData();
        print("code:-"+response.statusCode.toString());

        return postmanTestModel;
      } else {
        print("response code:-" + response.statusCode.toString());
        print("data not fetch");
        return null;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      print("List Length:-"+distributorList.length.toString());
    });
  }

  Future<void> getDistributorData() async {
   print("strat");


    setState(() {
      for (var i = 0; i < postmanTestModel.data.length; i++) {
        if (postmanTestModel.data[i].type.toString() == "Distributor") {
          distributorList.add(postmanTestModel.data[i]);
        }else{
          RetailorList.add(postmanTestModel.data[i]);

        }
      }
      // print(distributorList);
      // print(distributorList.length);
      // print(postmanTestModel.data.length);
      // print(postmanTestModel.data[0].type.toString());
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
      body: Column(
        children: [
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
                      color:
                          type == "retailer" ? Colors.black : Color(0x35000000),
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

          Expanded(
            child: Stack(
              children:[
                ListView.builder(
                itemCount: type == "distributor"? distributorList.length:RetailorList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(type == "distributor"? distributorList[index].businessName:RetailorList[index].businessName,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Icon(Icons.location_on_outlined),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      type == "distributor"? distributorList[index].address:RetailorList[index].address,
                                      textWidthBasis: TextWidthBasis.parent,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],),

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
                                      fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  type == "distributor"? distributorList[index].isApproved==0?"NON-Active":"Active" :RetailorList[index].isApproved==0?"NON-Active":"Active",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff1df19f)),
                                ),
                              ],
                            ),

                            Text("ID:-"+(type == "distributor"? distributorList[index].id:RetailorList[index].id),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("Bussiness Type:-"+(type == "distributor"? distributorList[index].businessType:RetailorList[index].businessType),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("GST no.:-"+(type == "distributor"? distributorList[index].gstNo:RetailorList[index].gstNo),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("PinCode:-"+(type == "distributor"? distributorList[index].pincode:RetailorList[index].pincode),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("Name:-"+(type == "distributor"? distributorList[index].name:RetailorList[index].name),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("Mobile:-"+(type == "distributor"? distributorList[index].mobile:RetailorList[index].mobile),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("State.:-"+(type == "distributor"? distributorList[index].state:RetailorList[index].state).toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("City:-"+(type == "distributor"? distributorList[index].city:RetailorList[index].city).toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("Regin ID:-"+(type == "distributor"? distributorList[index].regionId:RetailorList[index].regionId),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("Area Id:-"+(type == "distributor"? distributorList[index].areaId:RetailorList[index].areaId),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("App pk.:-"+(type == "distributor"? distributorList[index].appPk:RetailorList[index].appPk),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("Image:-"+(type == "distributor"? distributorList[index].image:RetailorList[index].image).toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("Bank account ID:-"+(type == "distributor"? distributorList[index].bankAccountId:RetailorList[index].bankAccountId),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("isApproved:-"+(type == "distributor"? distributorList[index].isApproved:RetailorList[index].isApproved),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("open Time.:-"+(type == "distributor"? distributorList[index].openTime:RetailorList[index].openTime),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("close Time:-"+(type == "distributor"? distributorList[index].closeTime:RetailorList[index].closeTime),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("Parent ID:-"+(type == "distributor"? distributorList[index].parentId:RetailorList[index].parentId),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("is async:-"+(type == "distributor"? distributorList[index].isAsync:RetailorList[index].isAsync),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),

                            Text("Brand.:-"+(type == "distributor"? distributorList[index].brands:RetailorList[index].brands).toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text("is delete:-"+(type == "distributor"? distributorList[index].isDelete:RetailorList[index].isDelete),
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
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Distributorandretailordetailpage()));
                    },
                    child: Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.add,color: Colors.white,size: 30,),
                      ),                ),
                  ),
                )

              ]
            ),
          )
        ],
      ),
    );
  }
}
