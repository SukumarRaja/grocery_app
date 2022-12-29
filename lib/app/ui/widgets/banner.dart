import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home.dart';
import '../themes/colors.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10.0)),
        child: Obx(
          () => PageView.builder(
              itemCount: HomeController.to.bannerImages.length,
              itemBuilder: (context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    HomeController.to.bannerImages[index],
                    fit: BoxFit.cover,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
