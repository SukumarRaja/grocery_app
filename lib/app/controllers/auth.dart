import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocerry_app/app/controllers/file.dart';

import '../ui/pages/buyers/home/home_main.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final registerKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController lEmail = TextEditingController();
  TextEditingController lPassword = TextEditingController();

  final _showErrorMessage = false.obs;

  get showErrorMessage => _showErrorMessage.value;

  set showErrorMessage(value) {
    _showErrorMessage.value = value;
  }

  final _registerLoading = false.obs;

  get registerLoading => _registerLoading.value;

  set registerLoading(value) {
    _registerLoading.value = value;
  }

  final _loginLoading = false.obs;

  get loginLoading => _loginLoading.value;

  set loginLoading(value) {
    _loginLoading.value = value;
  }

  final _logoutLoading = false.obs;

  get logoutLoading => _logoutLoading.value;

  set logoutLoading(value) {
    _logoutLoading.value = value;
  }

  final _profileImage = "".obs;

  get profileImage => _profileImage.value;

  set profileImage(value) {
    _profileImage.value = value;
  }

  register() async {
    debugPrint("name ${name.text}");
    debugPrint("email ${email.text}");
    debugPrint("phone ${phone.text}");
    debugPrint("password ${password.text}");
    registerLoading = true;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      var image =
          await uploadProfileImageToStorage(image: FileController.to.pickImage);
      if (image != null) {
        profileImage = image;
      } else {
        profileImage = "";
      }
      if (credential.user!.uid.isNotEmpty) {
        await firestore.collection("buyers").doc(credential.user!.uid).set({
          "name": name.text,
          "email": email.text,
          "phone": phone.text,
          "password": password.text,
          "image": profileImage,
          "buyerId": credential.user!.uid,
        }).whenComplete(() {
          registerLoading = false;
          Get.off(() => HomeMain());
          registerKey.currentState!.reset();
          debugPrint("register successfully");
        });
      } else {
        registerLoading = false;
        debugPrint("register successfully bt data not stored in database");
      }
    } catch (e) {
      registerLoading = false;
      debugPrint("register unsuccessfully $e");
    }
  }

  login() async {
    loginLoading = true;
    try {
      await auth
          .signInWithEmailAndPassword(
              email: lEmail.text, password: lPassword.text)
          .whenComplete(() {
        loginLoading = false;
        Get.off(() => HomeMain());
        loginKey.currentState!.reset();
        debugPrint("Login successfully");
      });
    } catch (e) {
      loginLoading = false;
      debugPrint("Login failed $e");
    }
  }

  logout() async {
    logoutLoading = true;
    try {
      await auth.signOut();
      logoutLoading = false;
      debugPrint("Logout Successfully");
    } catch (e) {
      logoutLoading = false;
      debugPrint("Logout failed $e");
    }
  }

  uploadProfileImageToStorage({required image}) async {
    Reference ref =
        storage.ref().child("profilePics").child(auth.currentUser!.uid);
    UploadTask task = ref.putData(image);
    TaskSnapshot snapshot = await task;
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
