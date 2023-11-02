import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/auth/login/controller/login_controller.dart';
import 'package:magazine/app_module/auth/register/view/components/register_components.dart';
import 'package:magazine/services/firebase/firebaseAuth.dart';
import 'package:magazine/services/firebase/helper_function.dart';
import 'package:magazine/utils/constants/images_string.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginController = Get.put(LoginControler());
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

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
                          height: 30,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        fieldWithTitle(
                            title: "Email", controller: nameController),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Obx(() {
                            return fieldWithTitle(
                                title: "Password",
                                hint: "Enter password",
                                controller: passwordController,
                                isPassword: true,
                                onTap: () {
                                  loginController.isShowPassword.toggle();
                                },
                                obsecure: loginController.isShowPassword.value);
                          }),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Obx(() => loginController.isLoginLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.PURPLE_COLOR,
                                ),
                              )
                            : AppButton(
                                buttonName: "Login",
                                buttonWidth: Get.width,
                                buttonRadius: BorderRadius.circular(10),
                                buttonColor: AppColors.PURPLE_COLOR,
                                textColor: AppColors.WHITE_COLOR,
                                onTap: () {
                                  //

                                  loginController.isLoginLoading(true);
                                  AuthenticationHelper()
                                      .signIn(
                                          email: nameController.text,
                                          password: passwordController.text)
                                      .then((result) async {
                                    if (result == null) {
                                      // final contl = Get.put(QAController());
                                      await Get.put(UserDataController())
                                          .getUserData();
                                      HelperFunctions.saveInPreference("uid",
                                          "${FirebaseAuth.instance.currentUser?.uid}");
                                      // Get.to(const HomeScreen());

                                      // Get.offAll(HomeView());
                                      Get.offAllNamed("/home1");
                                      Get.snackbar(
                                        "Login",
                                        "Login Succesfully",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(seconds: 2),
                                        colorText: Colors.white,
                                        backgroundColor: AppColors.PURPLE_COLOR,
                                      );

                                      loginController.isLoginLoading(false);
                                    } else {
                                      loginController.isLoginLoading(false);
                                    }
                                  });
                                })),
                        const SizedBox(
                          height: 15,
                        ),
                        createAccount()
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
