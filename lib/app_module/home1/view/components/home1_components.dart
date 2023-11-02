// ignore_for_file: sized_box_for_whitespace, deprecated_member_use, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:magazine/app_module/auth/login/controller/login_controller.dart';
import 'package:magazine/app_module/home/model/home_model.dart';
import 'package:magazine/utils/constants/images_string.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_text.dart';

//   AppBar

Widget appBar(
    {bool isBack = true,
    String? title,
    VoidCallback? onTap,
    bool isSufix = true}) {
  return Container(
    height: Get.height / 9,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onTap ??
                    () {
                      Get.back();
                    },
                child: Container(
                  color: AppColors.TRANSPARENT_COLOR,
                  // height: 30,
                  width: 23,
                  child: Image.asset(
                    isBack ? AppImages.BACK_ICON : AppImages.MENU_ICON,
                  ),
                ),
              ),
              isSufix
                  ? const Spacer()
                  : const SizedBox(
                      width: 15,
                    ),
              appText(text: title ?? "Magazine", fontWeight: FontWeight.w600),
              isSufix ? const Spacer() : Container(),
              GestureDetector(
                onTap: () { Get.toNamed("/profile");},
                child: Container(
                  // color: Colors.black,
                  // height: 30,
                  width: 22,
                  child: const Icon(
                    Icons.account_circle_sharp,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget quickLisk(){
  return SizedBox(
    height: Get.width*0.32,
    child: GridView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            childAspectRatio: 1),
        itemCount: AppImages.quickImages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if(index == 1){
                Get.toNamed("/home");
              }
            },
            // mainMenuList[index]["onTap"],
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xfff17626),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.swiperImages[index]),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    width: Get.width*0.13, height: Get.width*0.13,
                  ),
                  const SizedBox(height: 5,),
                  index == 0 ? appText(text: "OG NEWS", size: 17, color: Colors.white):
                  index == 1 ? appText(text: "MAGAZINES", size: 17, color: Colors.white):
                  appText(text: "TRIPS", size: 17, color: Colors.white)
                ],
              ),
            ),
          );
        }
    ),
  );
}
Widget ogChannels(){
  return Container(
    margin: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: Get.width*0.3,
          child: Card(
            child: Container(
              color: Colors.blue,
            ),
          ),
        );
      },
    ),
  );
}
Widget swiper(){
  return SizedBox(
    width: Get.width*0.9,
    height: Get.height*0.2,
    child: Swiper(
      itemBuilder: (context, index){
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.swiperImages[index]),
              fit: BoxFit.fill,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 10),
                    child: appText(text: "signup To Our \npremium membership \nTODAY",
                        size: 20, color: Colors.white
                    ),
                  )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: Get.width*0.25,
                  height: 35,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15, bottom: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: appText(text: "More Info", size: 16, color: Colors.orange),
                ),
              )
            ],
          ),
          // child: Image.asset("assets/images/login.png",fit: BoxFit.fill,),
        );
      },
      autoplay: true,
      itemCount: AppImages.swiperImages.length,
      pagination: const SwiperPagination(
        alignment: Alignment.bottomCenter,
        builder: DotSwiperPaginationBuilder(
            color: Colors.white, activeColor: Color(0xFFdfa16b)),
      ),
    ),
  );
}
Widget latestBook(){
  final userController = Get.put(UserDataController());
  return Obx(() {
    return userController.isBookLoading.value
        ? Center(
        child: CircularProgressIndicator(
          color: AppColors.PURPLE_COLOR,
        ),
    ): Row(
      children: [
        SizedBox(width: Get.width*0.05,),
        GestureDetector(
          child: SizedBox(
            height: Get.height*0.17,
            width: Get.width*0.2,
            child: Image.network(userController.booksList.reversed.toList().first["thumbnail"]),
          ),
          onTap: (){
            Get.toNamed("/reader", arguments: [
              userController.booksList.reversed.toList().first["name"],
              userController.booksList.reversed.toList().first["bookurl"]
            ]);
          },
        ),
        const SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: appText(text: userController.booksList.reversed.toList().first['name']+" NOW!", size: 15, color: const Color(0xfff17626)),
            ),
            SizedBox(
              width: Get.width*0.65,
              child: appText(text:
              "Click here to read the newest addition of our magazine. Enjoy free access to OG 66 O-Edition. Want more?? Members signed up to our E-Membership have access to the fully unlocked E-edition so you don't miss a thin!",
                  size: 14, color: Colors.black54
              ),
            ),
          ],
        )
      ],
    );
  });
}
//  Grid View
Widget gridView() {
  final userController = Get.put(UserDataController());
  return Obx(() {
    return userController.isBookLoading.value
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.PURPLE_COLOR,
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8,
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                childAspectRatio: .7),
            itemCount: userController.booksList.reversed.toList().length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed("/reader", arguments: [
                    userController.booksList.reversed.toList()[index]["name"],
                    userController.booksList.reversed.toList()[index]["bookurl"]
                  ]);
                },
                // mainMenuList[index]["onTap"],
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          height: 120,
                          child: CachedNetworkImage(
                            imageUrl: userController.booksList.reversed
                                .toList()[index]["thumbnail"],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.PURPLE_COLOR,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    appText(
                        text: userController.booksList.reversed.toList()[index]
                            ["name"],
                        maxline: 2,
                        textAlign: TextAlign.center,
                        size: 12)
                  ],
                ),
              );
            });
  });
}

//  Drawer

Widget drawer() {
  return Drawer(
    width: Get.width / 1.75,
    child: Container(
      color: AppColors.PURPLE_COLOR.withOpacity(.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: Get.width / 1.75,
            decoration: BoxDecoration(
                color: AppColors.WHITE_COLOR,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, left: 16),
                  child: Obx(() {
                    return appText(
                        text:
                            "Hey ${Get.put(UserDataController()).name.value.split(" ").first}!",
                        size: 30);
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: drawerMenuList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: index == 1
                    ? () {
                        if (Get.put(UserDataController()).rateUrl.value != "") {
                          launch(Get.put(UserDataController()).rateUrl.value);
                        }
                      }
                    : index == 2
                        ? () {
                            if (Get.put(UserDataController()).shareUrl.value !=
                                "") {
                              Share.share(
                                  Get.put(UserDataController()).shareUrl.value,
                                  subject: 'Magazine');
                            }
                          }
                        : drawerMenuList[index]["onTap"],
                child: Padding(
                  padding: const EdgeInsets.only(top: 23, left: 16),
                  child: Row(
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                            color: AppColors.PURPLE_COLOR,
                            shape: BoxShape.circle),
                        child: Image.asset(
                          drawerMenuList[index]["icon"],
                          color: AppColors.WHITE_COLOR,
                        ),
                      ),
                      appText(text: drawerMenuList[index]["title"], size: 18)
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    ),
  );
}
