import 'package:get/get.dart';
import 'package:magazine/services/Network/GetXNetworkManager/getx_network_manager.dart';

class BindingNetwork extends Bindings {
  @override
  void dependencies() {
    Get.put<GetXNetworkManager>(GetXNetworkManager());
  }
}
