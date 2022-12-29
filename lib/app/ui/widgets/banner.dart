import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: PageView(
          children: [
            Center(child: Text("1"),),
            Center(child: Text("2"),),
            Center(child: Text("3"),),
          ],
        ),
      ),
    );

  }
}
