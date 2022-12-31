import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FileController extends GetxController {
  static FileController get to => Get.put(FileController());

  final _isPicked = false.obs;

  get isPicked => _isPicked.value;

  set isPicked(value) {
    _isPicked.value = value;
  }

  final ImagePicker picker = ImagePicker();
  Uint8List? pickImage;

  pickProfileImage({required ImageSource source}) async {
    XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      isPicked = true;
      update();
      return await file.readAsBytes();
    } else {
      isPicked = false;
      update();
      debugPrint("No image selected");
    }
  }

  selectGallery() async {
    Uint8List image = await pickProfileImage(source: ImageSource.gallery);
    pickImage = image;
    update();
  }

  selectCamera() async {
    Uint8List image = await pickProfileImage(source: ImageSource.camera);
    pickImage = image;
    update();
  }
}
