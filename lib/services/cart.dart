import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/models/cart_model.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:foody/pages/cart/cart_history.dart';

class CartService {
  String? uid;

  var fireStore = FirebaseFirestore.instance;

  Future addCartHistoryToFireStore(List<CartModel> cartHistory) async {
    if (uid != null) {
      try {
        fireStore
            .collection("user")
            .doc(uid)
            .set(CartHistoryModel(cartHistory).toJSON());
        // fireStore.collection('user')
      } catch (e) {
        print((e as FirebaseException).message);
      }
    } else {
      print("No uid");
    }
  }

  Future<List<CartModel>> getCartHistoryFromFireStore() async {
    List<CartModel> cartHistoryItems = [];
    if (uid != null) {
      var userDoc = await fireStore.collection("user").doc(uid).get();
      if (userDoc.data() != null) {
        var cartHistoryList = CartHistoryModel.fromJSON(userDoc.data()!);
        cartHistoryItems = cartHistoryList.cartHistoryItems;
      }
    } else {
      print("No uid");
    }
    return cartHistoryItems;
  }
}
