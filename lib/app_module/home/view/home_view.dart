// ignore_for_file: must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/home/controller/home_controller.dart';
import 'package:magazine/app_module/home/view/components/home_components.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController());

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      body: Container(
        // height: Get.height,
        // width: Get.width,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(AppImages.BLUE_BG_IMAGE), fit: BoxFit.cover)),
        child: Column(
          children: [
            appBar(
                isBack: true,
                onTap: () {
                  Get.back();
                  // scaffoldKey.currentState?.openDrawer();
                }),
            Expanded(child: gridView())
          ],
        ),
      ),
    );
  }
}
