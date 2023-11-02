import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_text.dart';
import 'package:magazine/utils/widgets/app_text_field.dart';

//   TextField With Title

Widget fieldWithTitle(
    {TextEditingController? controller,
    String? title,
    String? hint,
    bool isOnlyRead = false,
    bool isPassword = false,
    VoidCallback? onTap,
    bool obsecure = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appText(text: title ?? "Email", color: AppColors.GREY_COLOR, size: 15),
      const SizedBox(
        height: 5,
      ),
      AppTextField(
        hint: hint ?? "Enter your email..",
        isborderline: true,
        controller: controller,
        obsecure: obsecure,
        isShowCursor: !isOnlyRead,
        isReadOnly: isOnlyRead,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        hintSize: 15,
        maxLines: 1,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onTap ?? () {},
                child: Icon(obsecure ? Icons.visibility_off : Icons.visibility))
            : null,
        isFill: true,
        fillColor: AppColors.GREY_COLOR.withOpacity(.15),
        borderRadius: BorderRadius.circular(10),
        borderColor: AppColors.GREY_COLOR.withOpacity(.01),
      )
    ],
  );
}

//   Alreday Have Acoount

Widget alreadyAccount() {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/login");
      GetStorage().write("is_read", "true");
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appText(text: "Already have an account?", size: 13),
        appText(text: " Login", size: 13, color: AppColors.PURPLE_COLOR)
      ],
    ),
  );
}

Widget createAccount() {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/register");
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appText(text: "Don't have an account?", size: 13),
        appText(text: " Register", size: 13, color: AppColors.PURPLE_COLOR)
      ],
    ),
  );
}

//

BoxDecoration topRoundedSheet() {
  return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(0, -5), // Shadow position
        ),
      ],
      color: AppColors.WHITE_COLOR,
      border: Border.all(color: AppColors.GREY_COLOR.withOpacity(.2)),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));
}
