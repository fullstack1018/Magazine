import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_button.dart';
import 'package:magazine/utils/widgets/app_text.dart';

showDialog() {
  return Get.defaultDialog(
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(inherit: false),
      contentPadding: EdgeInsets.zero,
      content: Column(
        children: [
          SizedBox(
              height: Get.height / 6,
              width: Get.height / 6,
              child: Lottie.asset('assets/lotifiles/errorloti.json')),
          SizedBox(
            height: Get.height / 30,
          ),
          appText(text: "Connection Error"),
          SizedBox(
            height: Get.height / 50,
          ),
          AppButton(
              buttonName: "Try Again",
              buttonHeight: Get.height / 20,
              textSize: 20,
              buttonColor: AppColors.BULE_COLOR,
              textColor: AppColors.WHITE_COLOR,
              buttonRadius: BorderRadius.circular(25),
              onTap: () {
                Get.back();
              }),
          SizedBox(
            height: Get.height / 100,
          ),
        ],
      ));
}

hideDialog() {
  Get.isDialogOpen! ? Get.back() : null;
}
