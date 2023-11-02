import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magazine/app_module/auth/register/view/components/register_components.dart';
import 'package:magazine/utils/constants/images_string.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_button.dart';
import 'package:magazine/utils/widgets/app_text.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
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
              padding: const EdgeInsets.only(
                top: 70,
              ),
              child: Center(
                child: appText(
                    text: "Let's Get Started",
                    size: 40,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
              child: Image.asset(AppImages.APP_LOGO_ICON),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppButton(
                  buttonName: "Sign Up",
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonColor: AppColors.PURPLE_COLOR,
                  textColor: AppColors.WHITE_COLOR,
                  onTap: () {
                    Get.toNamed("/register");
                    GetStorage().write("is_read", "true");
                  }),
            ),
            // const SizedBox(
            //   height: 50,
            // ),
            alreadyAccount()
          ],
        ),
      ),
    );
  }
}
