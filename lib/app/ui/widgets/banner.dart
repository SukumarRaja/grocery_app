import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../controllers/home.dart';
import '../themes/colors.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage == 4) {
        end = true;
      } else if (currentPage == 0) {
        end = false;
      }

      if (end == false) {
        currentPage++;
      } else {
        currentPage--;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
                // color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.0)),
            child: Obx(
              () => PageView.builder(
                  controller: pageController,
                  itemCount: HomeController.to.bannerImages.length,
                  itemBuilder: (context, int index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: HomeController.to.bannerImages[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Shimmer(
                                duration: const Duration(seconds: 10),
                                interval: const Duration(seconds: 10),
                                color: AppColors.white,
                                colorOpacity: 0,
                                enabled: true,
                                direction: const ShimmerDirection.fromLTRB(),
                                child: Container(
                                  color: AppColors.grey.withOpacity(.2),
                                ));
                          },
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ));
                  }),
            ),
          ),
          // Container(
          //   height: 50,
          //   child: ListView.builder(
          //       itemCount: HomeController.to.bannerImages.length,
          //       scrollDirection: Axis.horizontal,
          //       shrinkWrap: true,
          //       itemBuilder: (context, int index) {
          //         return Row(
          //           children: [
          //             Container(
          //               margin: EdgeInsets.all(3),
          //               height: 10,
          //               width: 10,
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: AppColors.primary,
          //               ),
          //             ),
          //           ],
          //         );
          //       }),
          // )
        ],
      ),
    );
  }
}
