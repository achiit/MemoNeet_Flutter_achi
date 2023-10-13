// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/services.dart' as rootbundle;
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

// class HiveDb {
//   Box? box;
//   var data;
//   var jsonData;

//   Future openBox() async {
//     var dir = await getApplicationDocumentsDirectory();
//     Hive.init(dir.path);
//     box = await Hive.openBox('data');
//     if (box?.toMap().values.toList().isEmpty == true) {
//       await putDataInBox();
//     } else {}
//   }

//   Future<List> readJsonData(String startID, String endID) async {
//     log("_______IN READ");
//     box = await Hive.openBox('data');

//     List topicsName = [];
//     var myMap = box?.toMap().values.toList();
//     log("_______IN DATRE:${box?.toMap().values.toList()}");
//     data = myMap;
//     for (var i = 0; i < data.length; i++) {
//       if (int.parse(data[i]['unique_id'] == "" ? "0" : data[i]['unique_id'].toString()) >= int.parse(startID.toString()) &&
//           int.parse(data[i]['unique_id'] == "" ? "0" : data[i]['unique_id'].toString()) <= int.parse(endID.toString())) {
//         if (data[i]['quiz_type'] != "notes") {
//           topicsName.add(data[i]);
//         }
//       }
//     }
//     return topicsName;
//   }

//   Future putDataInBox() async {
//     log("____________IN PUT DATA HIVE");

//     jsonData = await rootbundle.rootBundle.loadString('jsonFiles/biology.json');
//     List list = jsonDecode(jsonData);
//     //insert Data
//     for (var d in list) {
//       box?.add(d);
//     }
//   }

//   Future<List> readJsonDataofRevision(List<RevisionModel> uniqueIds) async {
//     box = await Hive.openBox('data');
//     List topicsName = [];
//     var myMap = box?.toMap().values.toList();
//     data = myMap;
//     for (var i = 0; i < data.length; i++) {
//       if (uniqueIds.any((element) => int.parse(element.uniqueID.last) == int.parse(data[i]['unique_id'].toString() == "" ? "0" : data[i]['unique_id'].toString()))) {
//         topicsName.add(data[i]);
//       }
//     }
//     return topicsName;
//   }

//   Future revisionBox() async {
//     var dir = await getApplicationDocumentsDirectory();
//     Hive.init(dir.path);
//     box = await Hive.openBox('revision');
//     if (box?.toMap().values.toList().isEmpty == true) {
//       await setRivison();
//     } else {}
//   }

//   Future fetchRivision() async {
//     box = await Hive.openBox('revision');
//     var myMap = box?.toMap().values.toList();
//     log("_______________REVISION:$myMap");
//     return myMap;
//   }

//   Future setRivison() async {
//     box?.put('nth_revision', 0);
//     box?.put('date', DateTime.now());
//     box?.put('completed', 0);
//   }

//   Future updateRevision(int revision, DateTime date, int completed) async {
//     box?.put('nth_revision', revision);
//     box?.put('date', date);
//     box?.put('completed', completed);
//   }
// }
