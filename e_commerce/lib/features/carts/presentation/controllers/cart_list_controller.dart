import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/core/models/network_response.dart';
import 'package:e_commerce/core/services/network_caller.dart';
import 'package:e_commerce/features/carts/data/models/cart_item_model.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  List<CartItemModel> _cartItemList = [];

  bool get inProgress => _inProgress;

  List<CartItemModel> get cartItemList => _cartItemList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
    );
    if (response.isSuccess) {
      List<CartItemModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(CartItemModel.fromJson(jsonData));
      }
      _cartItemList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  int get totalPrice {
    int total = 0;
    for (CartItemModel item in _cartItemList) {
      total += (item.quantity * item.product.currentPrice);
    }

    return total;
  }

  void updateCart(String cartItemId, int quantity) {
    _cartItemList.firstWhere((item) => item.id == cartItemId)
        .quantity = quantity;
    update();
  }
}
