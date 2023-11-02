// ignore_for_file: must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/home1/controller/home1_controller.dart';
import 'package:magazine/utils/constants/images_string.dart';

import '../../../utils/theme/app_color.dart';
import '../../../utils/widgets/app_text.dart';
import '../../auth/login/controller/login_controller.dart';
import 'components/home1_components.dart';

class FirstHomeView extends StatefulWidget {
  const FirstHomeView({super.key});
  @override
  State<FirstHomeView> createState() => _FirstHomeViewState();
}

class _FirstHomeViewState extends State<FirstHomeView> {

  final firstHomeController = Get.put(FirstHomeController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  late var userController;

  @override
  void initState() {
    setState(() {
      userController = Get.put(UserDataController());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              appBar(
                  isBack: false,
                  title: "Ocean Geographic",
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  }
              ),
              Container(
                height: 45,
                padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                alignment: Alignment.center,
                child: TextField(
                  controller: searchController,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Color(0xfffee2cc), width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Color(0xfffee2cc), width: 1.0),
                    ),
                    filled: true,
                    fillColor: Color(0xfffee2cc),
                    suffixIcon: Icon(Icons.search_rounded, color: Color(0xFFdfa16b),),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 10,),
              swiper(),
              const SizedBox(height: 5,),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: Get.width*0.05),
                  child: appText(text: " Quick Links", size: 18, color: const Color(0xFFdfa16b))
              ),
              quickLisk(),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: Get.width*0.05),
                child: appText(text: "NEW ISSUE ALERT", size: 16),
              ),
              const SizedBox(height: 5,),
              latestBook(),
              const SizedBox(height: 5,),
              appText(text: "OG Channels", size: 18),
              Expanded(
                child: ogChannels()
              )
            ],
          ),
        ),
      ),
    );
  }
}
