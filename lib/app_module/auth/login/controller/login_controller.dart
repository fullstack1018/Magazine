// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginControler extends GetxController {
  var isShowPassword = true.obs;
  var isLoginLoading = false.obs;
}

class UserDataController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  var name = "".obs;
  var email = "".obs;
  var isPremium = false.obs;
  var password = "".obs;
  var shareUrl = "".obs;
  var rateUrl = "".obs;
  var policyUrl = "".obs;

  var isLoading = true.obs;
  var booksList = [].obs;

  var isBookLoading = true.obs;
  var isUpdateLoading = false.obs;

  updateShare(val) {
    shareUrl.value = val;
    update();
  }

  updateRate(val) {
    rateUrl.value = val;
    update();
  }

  updatePolicy(val) {
    policyUrl.value = val;
    update();
  }

  updateName(val) {
    name.value = val;
    update();
  }

  updateEmail(val) {
    email.value = val;
    update();
  }

  @override
  void onInit() {
    getUserData();
    getBooksData();
    super.onInit();
  }

  getUserData() async {
    isLoading(true);

    await _fireStore.collection('Users').doc(user.uid).get().then((value) {
      name.value = value.data()!["name"];
      email.value = value.data()!["email"];
      password.value = value.data()!["password"];
      isPremium.value = value.data()!["is_premium"];
      update();
    });

    isLoading(false);

    update();
  }

  getBooksData() async {
    isBookLoading(true);

    await _fireStore.collection('Magazine').get().then((value) {
      updateRate(value.docs[1].data()['rate']);
      updatePolicy(value.docs[1].data()['policy']);
      updateShare(value.docs[1].data()['share']);

      for (var i = 0; i < value.docs[0].data()["books"].length; i++) {
        if (isPremium.isTrue) {
          if (value.docs[0].data()["books"][i]['type'] == "e") {
            booksList.add(value.docs[0].data()["books"][i]);
          }
        } else {
          if (value.docs[0].data()["books"][i]['type'] == "o") {
            booksList.add(value.docs[0].data()["books"][i]);
          }
        }
      }

      print("length: ${booksList.length}");
      // name.value = value.docs[0].data()["name"];
      // email.value = value.docs[0].data()["email"];
      // password.value = value.docs[0].data()["password"];
      // isPremium.value = value.docs[0].data()["is_premium"];
      update();
    });

    isBookLoading(false);

    update();
  }

  updatedata() async {
    isUpdateLoading(true);
    await _fireStore.collection('Users').doc(user.uid).update(
      {
        "name": name.value,
        "email": email.value,
        "is_premium": false,
        "password": password.value,
      },
    ).then((result) {
      isUpdateLoading(false);
      Get.toNamed("/home");
      getUserData();
    }).catchError((onError) {});
  }
}
