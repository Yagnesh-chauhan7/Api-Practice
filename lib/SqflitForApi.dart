
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:postman_api_test/PostmanTestModel.dart';
import 'package:sqflite/sqflite.dart';


class ApiLocalDB {

Future<Database> getDatabaseForDistributor() async{

  var databasePath = await getDatabasesPath();

  final database = openDatabase(join(databasePath,'api.db'),
  onCreate: (db, version) {
 db.execute('CREATE TABLE API_DISTRIBUTOR(id TEXT,type TEXT,business_name TEXT,business_type TEXT,gst_no TEXT,address TEXT,pincode TEXT,name TEXT,mobile TEXT,state TEXT,city TEXT,region_id TEXT,area_id TEXT, app_pk TEXT,image TEXT, bank_account_id TEXT,isApproved TEXT,open_time TEXT,close_time TEXT,parent_id TEXT,is_async TEXT,brands TEXT,is_delete TEXT)');

db.execute('CREATE TABLE API_RETAILER(id TEXT,type TEXT,business_name TEXT,business_type TEXT,gst_no TEXT,address TEXT,pincode TEXT,name TEXT,mobile TEXT,state TEXT,city TEXT,region_id TEXT,area_id TEXT, app_pk TEXT,image TEXT, bank_account_id TEXT,isApproved TEXT,open_time TEXT,close_time TEXT,parent_id TEXT,is_async TEXT,brands TEXT,is_delete TEXT)');

return db;
  },
    version: 1
  );
  return database;
}

// Future<Database> getDatabaseForRetailer() async{
//
//   var databasePath = await getDatabasesPath();
//
//   final database = openDatabase(join(databasePath,'api.db'),
//       onCreate: (db, version) {
//         db.execute('CREATE TABLE API_RETAILER(id TEXT,type TEXT,business_name TEXT,business_type TEXT,gst_no TEXT,address TEXT,pincode TEXT,name TEXT,mobile TEXT,state TEXT,city TEXT,region_id TEXT,area_id TEXT, app_pk TEXT,image TEXT, bank_account_id TEXT,isApproved TEXT,open_time TEXT,close_time TEXT,parent_id TEXT,is_async TEXT,brands TEXT,is_delete TEXT)');
//       },
//       version: 1
//   );
//   return database;
// }

  Future<bool>  databaseExists(String dbName) async {
    // Get the application documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Build the full path to the database file
    String path = join(documentsDirectory.path, dbName);

    // Check if the database file exists
    return await File(path).exists();
  }


Future<void> InsertDataForDistibutor(Datum data) async {

  var db = await getDatabaseForDistributor();

  await db.insert('API_DISTRIBUTOR', data.toJson());

  print("insert Distributor successfully..");
}

Future<void> InsertDataForRetailer(Datum data) async {

  var db = await getDatabaseForDistributor();


  await db.insert('API_RETAILER', data.toJson());

  print("insert Retailer successfully..");
}
Future<List<Datum>?> AllDataRetriveForDistributor() async{

  final db = await getDatabaseForDistributor();

  final List<Map<String, Object?>> DataMap= await  db.query('API_DISTRIBUTOR');

  return [
    for(final {
    "id": id as String,
    "type": type as String,
    "business_name": businessName as String,
    "business_type": businessType as String,
    "gst_no": gstNo as String,
    "address": address as String,
    "pincode": pincode as String,
    "name": name as String,
    "mobile": mobile as String,
    "state": state as String,
    "city": city as String,
    "region_id": regionId as String,
    "area_id": areaId as String,
    "app_pk": appPk as String,
    "image": image as String,
    "bank_account_id": bankAccountId as String,
    "isApproved": isApproved as String,
    "open_time": openTime as String,
    "close_time": closeTime as String,
    "parent_id": parentId as String,
    "is_async": isAsync as String,
    "brands": brands as String,
    "is_delete": isDelete as String,
    } in  DataMap)

     Datum(id: id, type: type, businessName: businessName, businessType: businessType, gstNo: gstNo,
         address: address, pincode: pincode, name: name, mobile: mobile, regionId: regionId, areaId: areaId,
         appPk: appPk, bankAccountId: bankAccountId, isApproved: isApproved, openTime: openTime,
         closeTime: closeTime, parentId: parentId, isAsync: isAsync, isDelete: isDelete,state:state ,city: city,image:image ,brands: brands)

  ];
}


Future<List<Datum>?> AllDataRetriveForRetailer() async{

  final db = await getDatabaseForDistributor();

  final List<Map<String, Object?>> DataMap= await  db.query('API_RETAILER');

  return [
    for(final {
    "id": id as String,
    "type": type as String,
    "business_name": businessName as String,
    "business_type": businessType as String,
    "gst_no": gstNo as String,
    "address": address as String,
    "pincode": pincode as String,
    "name": name as String,
    "mobile": mobile as String,
    "state": state as String,
    "city": city as String,
    "region_id": regionId as String,
    "area_id": areaId as String,
    "app_pk": appPk as String,
    "image": image as String,
    "bank_account_id": bankAccountId as String,
    "isApproved": isApproved as String,
    "open_time": openTime as String,
    "close_time": closeTime as String,
    "parent_id": parentId as String,
    "is_async": isAsync as String,
    "brands": brands as String,
    "is_delete": isDelete as String,
    } in  DataMap)

      Datum(id: id, type: type, businessName: businessName, businessType: businessType, gstNo: gstNo,
          address: address, pincode: pincode, name: name, mobile: mobile, regionId: regionId, areaId: areaId,
          appPk: appPk, bankAccountId: bankAccountId, isApproved: isApproved, openTime: openTime,
          closeTime: closeTime, parentId: parentId, isAsync: isAsync, isDelete: isDelete,state:state ,city: city,image:image ,brands: brands)

  ];
}

}