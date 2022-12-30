import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'common_text.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Categories",
            fontWeight: FontWeight.w500,
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ActionChip(
                            backgroundColor: AppColors.primary.withOpacity(.5),
                            onPressed: () {},
                            label: CommonText(
                              text: "Food",
                              fontColor: AppColors.white,
                            )),
                      );
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
