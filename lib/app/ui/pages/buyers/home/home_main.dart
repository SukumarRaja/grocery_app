import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/main.dart';
import '../../../themes/colors.dart';
import 'home.dart';

class HomeMain extends StatelessWidget {
  HomeMain({Key? key}) : super(key: key);
  final List<Widget> pages = [
    Container(
      child: Center(
        child: Text("profile"),
      ),
    ),
    Container(
      child: Center(
        child: Text("categories"),
      ),
    ),
    Home(),
    Container(
      child: Center(
        child: Text("cart"),
      ),
    ),
    Container(
      child: Center(
        child: Text("search"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: MainController.to.pageIndex,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.grey,
          elevation: 25,
          selectedItemColor: AppColors.primary,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedIconTheme: const IconThemeData(color: AppColors.primary),
          unselectedIconTheme: const IconThemeData(color: AppColors.grey),
          onTap: (data) {
            MainController.to.pageIndex = data;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          ],
        ),
      ),
      body: Obx(() => pages[MainController.to.pageIndex]),
    );
  }
}
