// ignore_for_file: avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final _bannerImages = <dynamic>[].obs;

  get bannerImages => _bannerImages.value;

  set bannerImages(value) {
    _bannerImages.value = value;
  }

  getBanners() async {
    return fireStore.collection('banners').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        bannerImages.add(doc['image']);
        debugPrint("banner images $bannerImages");
        update();
      });
    });
  }
}
