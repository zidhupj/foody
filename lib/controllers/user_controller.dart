import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody/data/repository/card_repo.dart';
import 'package:foody/services/auth.dart';
import 'package:foody/services/cart.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final AuthService authService;

  UserController({required this.authService});

  late Rx<User?> _user;
  User? get user => _user.value;

  @override
  void onReady() {
    _user = Rx<User?>(authService.currentUser);
    _user.bindStream(authService.user);
    ever(_user, (User? user) async {
      print("The user was just changed!");
      Get.find<CartService>().uid = _user.value!.uid;
      Get.find<CartRepo>().initCartHistory =
          await Get.find<CartService>().getCartHistoryFromFireStore();
      print(user);
    });
    super.onReady();
  }

  Future signIn(String email, String password) async {
    try {
      dynamic user = await authService.signIn(email, password);
      print("Sign in successful");
      Get.back();
    } catch (e) {
      Get.snackbar(
          "Sign in failed", (e as FirebaseAuthException).message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future signUp(String email, String password) async {
    try {
      dynamic user = await authService.signUp(email, password);
      print("Sign up successful");
      Get.back();
    } catch (e) {
      Get.snackbar(
          "Sign up failed", (e as FirebaseAuthException).message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future editName(String name) async {
    var success = await authService.editName(name);
    if (!success) {
      Get.showSnackbar(const GetSnackBar(
        title: "Unable to edit name!",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      ));
    } else {
      update();
    }
  }
}
