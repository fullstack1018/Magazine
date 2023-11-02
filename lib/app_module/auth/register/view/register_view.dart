import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/auth/register/controller/register_controller.dart';
import 'package:magazine/app_module/auth/register/view/components/register_components.dart';
import 'package:magazine/services/firebase/firebaseAuth.dart';
import 'package:magazine/services/firebase/helper_function.dart';
import 'package:magazine/utils/constants/images_string.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_button.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final registerController = Get.put(RegisterControler());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 33,
                width: 33,
                margin: const EdgeInsets.only(top: 40, left: 16),
                decoration: BoxDecoration(
                    color: AppColors.WHITE_COLOR,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.GREY_COLOR.withOpacity(.25))),
                child: const Center(
                    child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                )),
              ),
            ),
            Center(
              child: SizedBox(
                height: 130,
                width: 130,
                child: Image.asset(
                  AppImages.APP_LOGO_ICON,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: topRoundedSheet(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        fieldWithTitle(
                          title: "Name",
                          hint: "Enter your name",
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        fieldWithTitle(
                          title: "Email",
                          controller: emailController,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Obx(() {
                            return fieldWithTitle(
                                controller: passwordController,
                                title: "Password",
                                hint: "Enter password",
                                isPassword: true,
                                onTap: () {
                                  registerController.isShowPassword.toggle();
                                },
                                obsecure:
                                    registerController.isShowPassword.value);
                          }),
                        ),
                        Obx(() {
                          return fieldWithTitle(
                              title: "Confirm Password",
                              hint: "Enter confirm password",
                              controller: confirmPasswordController,
                              isPassword: true,
                              onTap: () {
                                registerController.isShowConfirmPassword
                                    .toggle();
                              },
                              obsecure: registerController
                                  .isShowConfirmPassword.value);
                        }),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(
                          () => registerController.isRegisterLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.PURPLE_COLOR,
                                  ),
                                )
                              : AppButton(
                                  buttonName: "Register",
                                  buttonWidth: Get.width,
                                  buttonRadius: BorderRadius.circular(10),
                                  buttonColor: AppColors.PURPLE_COLOR,
                                  textColor: AppColors.WHITE_COLOR,
                                  onTap: () {
                                    // Get.toNamed("/login");

                                    if (nameController.text.isEmpty) {
                                      Get.snackbar(
                                        "Alert",
                                        "Please enter your name!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );
                                    } else if (emailController.text.isEmpty) {
                                      Get.snackbar(
                                        "Alert",
                                        "Please enter your email!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );
                                    } else if (passwordController
                                        .text.isEmpty) {
                                      Get.snackbar(
                                        "Alert",
                                        "Please enter your password!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );
                                    } else if (confirmPasswordController
                                        .text.isEmpty) {
                                      Get.snackbar(
                                        "Alert",
                                        "Please enter your confirm password!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );
                                    } else if (passwordController.text.length <
                                        6) {
                                      Get.snackbar(
                                        "Alert",
                                        "Password must be at least 6 letter!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );
                                    } else if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      Get.snackbar(
                                        "Alert",
                                        "Please enter same password!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );
                                    } else {
                                      registerController
                                          .isRegisterLoading(true);
                                      AuthenticationHelper().signUp(
                                          email: emailController.text,
                                          name: nameController.text,
                                          onChange: (val) {
                                            emailController.clear();
                                            nameController.clear();
                                            passwordController.clear();
                                            confirmPasswordController.clear();
                                            registerController
                                                .isRegisterLoading(false);

                                            HelperFunctions.saveInPreference(
                                                "uid",
                                                "${FirebaseAuth.instance.currentUser?.uid}");
                                            Get.toNamed("/login");
                                            Get.snackbar(
                                              "Alert",
                                              "Your account is created successfully",
                                              snackPosition: SnackPosition.TOP,
                                              duration:
                                                  const Duration(seconds: 2),
                                              colorText: Colors.white,
                                              backgroundColor:
                                                  AppColors.PURPLE_COLOR,
                                            );
                                          },
                                          password: passwordController.text);
                                    }
                                  }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        alreadyAccount()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
