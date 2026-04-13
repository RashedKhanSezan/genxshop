import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();

  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  Future<void> nextPage() async {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardingComplete', true);

      Get.offAllNamed(AppRoutes.login);
    }
  }

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Get the best sound",
      "description": "Kiwi Cedenza",
      "imageUrl":
          "https://cdn.shopify.com/s/files/1/0582/0317/7110/files/Kiwi_Ears_x_B_Media_Chorus_8.jpg?v=1774605173",
    },
    {
      "title": "Best IEM",
      "description": "Choose your iem",
      "imageUrl":
          "https://cdn.shopify.com/s/files/1/0582/0317/7110/files/800.jpg?v=1774605173",
    },
    {
      "title": "Explore your new music today",
      "description": "Best Sounding",
      "imageUrl":
          "https://cdn.shopify.com/s/files/1/0582/0317/7110/files/Kiwi_Ears_x_B_Media_Terras_15.jpg?v=1770373782",
    },
  ];
}
