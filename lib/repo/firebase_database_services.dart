import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:memo_neet/MVVM/models/banner/banner_model.dart';

class FirebaseDatabaseServices {
  // // getting the banners from firebase
  // Future<List<Map<dynamic, dynamic>>> getBanners() async {
  //   List<Map<dynamic, dynamic>> banner = [];
  //   final ref = FirebaseDatabase.instance.ref();
  //   final snapshot = await ref.child('ios/banners').get();
  //   if (snapshot.value != null) {
  //     for (var element in snapshot.children) {
  //       var obj = element;
  //       var imageUrl = obj.value as Map;
  //       banner.add(imageUrl);
  //     }
  //   } else {}
  //   return banner;
  // }

  Future<List<BannersModel>> getBanners() async {
    List<BannersModel> banners = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('ios/banners').get();

    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        banners.add(BannersModel(image: value['image'], link: value['link']));
      });
    }

    return banners;
  }

// getting the diagrams for mcqs
  Future<String> getDiagram(String folderName, String unique) async {
    log("__________UNIQUW ID:$unique");
    Reference reference =
        FirebaseStorage.instance.ref(folderName).child("$unique.jpg");
    String url = await reference.getDownloadURL();
    log("______url:$url");
    return url;
  }

  Future<String> getVideos(String unique) async {
    log("__________UNIQUW ID:$unique");
    Reference reference =
        FirebaseStorage.instance.ref("physics_temporary").child("$unique.jpg");
    String url = await reference.getDownloadURL();
    log("______url:$url");
    return url;
  }
}
