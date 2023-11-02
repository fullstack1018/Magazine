// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magazine/utils/constants/images_string.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser != null
          ? Get.offNamed("/home1")
          : GetStorage().read("is_read") == "true"
              ? Get.offNamed("/login")
              : Get.offNamed("/on_boarding");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.PURPLE_COLOR.withOpacity(.5),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.LIGHT_BG_IMAGE),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Center(
                  child: appText(
                      text: "Ocean Geographic", size: 50, color: AppColors.WHITE_COLOR),
                )
                //  Image.asset(
                //   AppImages.SPLASH_TEXT,
                //   height: 120,
                // ),
                ),
            const Spacer(),
            Center(
                child: appText(
                    text: "I am not lazy i'm just very relaxed",
                    color: Colors.white,
                    size: 16)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: LinearProgressIndicator(
                color: AppColors.PURPLE_COLOR,
                // value: .6,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
