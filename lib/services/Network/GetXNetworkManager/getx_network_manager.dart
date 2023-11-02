// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magazine/utils/widgets/app_dialog.dart';
import 'package:magazine/utils/widgets/app_text.dart';

class GetXNetworkManager extends GetxController {
  int connectionType = 0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  @override
  void onInit() {
    super.onInit();
    GetConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> GetConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      printLog(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    printLog(result);
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        hideDialog();
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        hideDialog();
        update();
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        hideDialog();
        showDialog();
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}
