import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/home.dart';
import '../../../themes/colors.dart';
import '../../../widgets/banner.dart';
import '../../../widgets/category_card.dart';
import '../../../widgets/common_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var top = MediaQuery.of(context);
    return GetBuilder(
        init: HomeController(),
        initState: (_) {
          HomeController.to.getBanners();
        },
        builder: (_) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: top.padding.top,
                    left: media.width * 0.08,
                    right: media.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CommonText(
                      text: "Suku, What Are You\n Looking For",
                      fontWeight: FontWeight.bold,
                    ),
                    Icon(Icons.shopping_cart)
                  ],
                ),
              ),
              SizedBox(height: media.width * 0.05),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: AppColors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        hintText: "Search For Products",
                        hintStyle: TextStyle(fontFamily: "Oswald"),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.grey.withAlpha(140),
                        )),
                  ),
                ),
              ),
              BannerWidget(),
              CategoryCard()
            ],
          );
        });
  }
}
