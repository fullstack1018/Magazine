import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magazine/app_module/splash/view/splash_view.dart';
import 'package:magazine/services/FCM/fcm_configuration.dart';
import 'package:magazine/services/Network/BindingNetwork/binding_network.dart';
import 'package:magazine/services/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await setupFlutterNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Magazine',
        debugShowCheckedModeBanner: false,
        initialBinding: BindingNetwork(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TokenMonitor((val) {
          // return CarrierDashboardView();
          // return MainMenuView();
          return const SplashView();
        }),
        // initialRoute: '/',
        getPages: MyRoutes.myroutes);
  }
}
