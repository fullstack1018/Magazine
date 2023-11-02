import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/auth/login/controller/login_controller.dart';
import 'package:magazine/app_module/home/view/components/home_components.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyView extends StatefulWidget {
  const PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  bool isLoading = true;

  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBar(isBack: true, title: "Privacy Policy"),
          Expanded(
            child: Get.put(UserDataController()).policyUrl.value == ""
                ? Center(
                    child: appText(text: "Coming soon.."),
                  )
                : Stack(
                    children: [
                      WebView(
                        initialUrl:
                            Get.put(UserDataController()).policyUrl.value,
                        key: _key,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageFinished: (finish) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                      isLoading
                          ? Container(
                              height: Get.height,
                              width: Get.width,
                              color: Colors.white,
                              child: loader())
                          : Stack(),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget loader() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.35,
        ),
        Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.black26,
          valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.PURPLE_COLOR //<-- SEE HERE

              ),
        )),
      ],
    );
  }
}
