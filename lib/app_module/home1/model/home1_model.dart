import 'package:get/get.dart';
import 'package:magazine/services/firebase/firebaseAuth.dart';
import 'package:magazine/utils/constants/images_string.dart';

List mainMenuList = [
  {
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0zbrXwkIVRdfvcED0a7nZmPBtARsTGywAKQ&usqp=CAU",
    "title": "Flutter",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/qrjet-d78e3.appspot.com/o/pdf%2Fflutter_tutorial.pdf?alt=media&token=d0ecc945-edb7-43d0-ad6c-7430ca1d15d2&_gl=1*1m3pvx3*_ga*NTAyODc1MjYwLjE2ODE3NTg4MDk.*_ga_CW55HF8NVT*MTY5NzUzNzg1NC43LjEuMTY5NzUzNzk5NS4zMi4wLjA.",
    "onTap": () {},
  },
  {
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0zbrXwkIVRdfvcED0a7nZmPBtARsTGywAKQ&usqp=CAU",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/qrjet-d78e3.appspot.com/o/pdf%2Fflutter_tutorial.pdf?alt=media&token=d0ecc945-edb7-43d0-ad6c-7430ca1d15d2&_gl=1*1m3pvx3*_ga*NTAyODc1MjYwLjE2ODE3NTg4MDk.*_ga_CW55HF8NVT*MTY5NzUzNzg1NC43LjEuMTY5NzUzNzk5NS4zMi4wLjA.",
    "title": "Flutter",
    "onTap": () {},
  },
  {
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0zbrXwkIVRdfvcED0a7nZmPBtARsTGywAKQ&usqp=CAU",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/qrjet-d78e3.appspot.com/o/pdf%2Fflutter_tutorial.pdf?alt=media&token=d0ecc945-edb7-43d0-ad6c-7430ca1d15d2&_gl=1*1m3pvx3*_ga*NTAyODc1MjYwLjE2ODE3NTg4MDk.*_ga_CW55HF8NVT*MTY5NzUzNzg1NC43LjEuMTY5NzUzNzk5NS4zMi4wLjA.",
    "title": "Flutter",
    "onTap": () {},
  },
  {
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0zbrXwkIVRdfvcED0a7nZmPBtARsTGywAKQ&usqp=CAU",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/qrjet-d78e3.appspot.com/o/pdf%2Fflutter_tutorial.pdf?alt=media&token=d0ecc945-edb7-43d0-ad6c-7430ca1d15d2&_gl=1*1m3pvx3*_ga*NTAyODc1MjYwLjE2ODE3NTg4MDk.*_ga_CW55HF8NVT*MTY5NzUzNzg1NC43LjEuMTY5NzUzNzk5NS4zMi4wLjA.",
    "title": "Flutter",
    "onTap": () {},
  },
  {
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0zbrXwkIVRdfvcED0a7nZmPBtARsTGywAKQ&usqp=CAU",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/qrjet-d78e3.appspot.com/o/pdf%2Fflutter_tutorial.pdf?alt=media&token=d0ecc945-edb7-43d0-ad6c-7430ca1d15d2&_gl=1*1m3pvx3*_ga*NTAyODc1MjYwLjE2ODE3NTg4MDk.*_ga_CW55HF8NVT*MTY5NzUzNzg1NC43LjEuMTY5NzUzNzk5NS4zMi4wLjA.",
    "title": "Flutter",
    "onTap": () {},
  },
];

List drawerMenuList = [
  {
    "icon": AppImages.PERSON_ICON,
    "title": "Profile",
    "onTap": () {
      Get.toNamed("/profile");
    },
  },
  {
    "icon": AppImages.RATE_ICON,
    "title": "Rate us",
    "onTap": () {},
  },
  {
    "icon": AppImages.SHARE_ICON,
    "title": "Share App",
    "onTap": () {},
  },
  {
    "icon": AppImages.LOCK_ICON,
    "title": "Privacy policy",
    "onTap": () {
      Get.toNamed("/privacy");
    },
  },
  {
    "icon": AppImages.LOGOUT_ICON,
    "title": "Logout",
    "onTap": () {
      AuthenticationHelper().signOut();
    },
  },
];
