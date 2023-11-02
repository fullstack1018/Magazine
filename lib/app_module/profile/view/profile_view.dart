// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/auth/login/controller/login_controller.dart';
import 'package:magazine/app_module/auth/register/view/components/register_components.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_button.dart';
import 'package:magazine/utils/widgets/app_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final userController = Get.put(UserDataController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    print(userController.name.value);
    print(userController.email.value);

    nameController.text = userController.name.value;
    emailController.text = userController.email.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 33,
                  width: 33,
                  margin: const EdgeInsets.only(
                    top: 40,
                    left: 16,
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.TRANSPARENT_COLOR,
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
              appText(text: "Profile"),
              Container(
                height: 33,
                width: 33,
                margin: const EdgeInsets.only(right: 16),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  fieldWithTitle(
                      title: "Name",
                      hint: "Enter your name",
                      controller: nameController),
                  const SizedBox(
                    height: 12,
                  ),
                  fieldWithTitle(
                      title: "Email",
                      controller: emailController,
                      isOnlyRead: true),
                  const SizedBox(
                    height: 60,
                  ),
                  Obx(() {
                    return userController.isUpdateLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                            color: AppColors.PURPLE_COLOR,
                          ))
                        : AppButton(
                            buttonName: "Update",
                            buttonWidth: Get.width,
                            buttonRadius: BorderRadius.circular(10),
                            buttonColor: AppColors.PURPLE_COLOR,
                            textColor: AppColors.WHITE_COLOR,
                            onTap: () {
                              Get.back();
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
                              } else {
                                userController
                                    .updateEmail(emailController.text);
                                userController.updateName(nameController.text);
                                userController.updatedata();
                              }
                            });
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
