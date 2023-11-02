import 'package:get/get.dart';
import 'package:magazine/app_module/auth/login/view/login_view.dart';
import 'package:magazine/app_module/auth/register/view/register_view.dart';
import 'package:magazine/app_module/home/view/home_view.dart';
import 'package:magazine/app_module/home1/view/home1_view.dart';
import 'package:magazine/app_module/on_boarding/view/on_boarding_view.dart';
import 'package:magazine/app_module/pdf_detail/view/pdf_reader_view.dart';
import 'package:magazine/app_module/privacy/view/privacy_view.dart';
import 'package:magazine/app_module/profile/view/profile_view.dart';
import 'package:magazine/app_module/splash/view/splash_view.dart';

class MyRoutes {
  static final myroutes = [
    GetPage(
      name: '/',
      page: () => const SplashView(),
    ),
    GetPage(
      name: '/on_boarding',
      page: () => const OnBoardingView(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginView(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterView(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeView(),
    ),
    GetPage(
      name: '/home1',
      page: () => FirstHomeView(),
    ),
    GetPage(
      name: '/reader',
      page: () => const PdfReaderView(),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfileView(),
    ),
    GetPage(
      name: '/privacy',
      page: () => const PrivacyView(),
    ),
  ];
}
