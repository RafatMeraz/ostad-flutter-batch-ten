import 'package:e_commerce/features/shared/data/models/product_model.dart';
import 'package:get/get.dart';

import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';

class ProductListController extends GetxController {
  int _currentPage = 0;

  int? _lastPageNo;

  final int _pageSize = 40;

  bool _getProductListInProgress = false;

  bool _isInitialLoading = false;

  final List<ProductModel> _productList = [];

  String? _errorMessage;

  bool get getProductsInProgress => _getProductListInProgress;

  bool get isInitialLoading => _isInitialLoading;

  List<ProductModel> get productList => _productList;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(String categoryId) async {
    bool isSuccess = false;

    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }
    if (_currentPage == 0) {
      _productList.clear();
      _isInitialLoading = true;
    } else {
      _getProductListInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.productList(_currentPage, _pageSize, categoryId));
    if (response.isSuccess) {
      _lastPageNo = response.body!['data']['last_page'];
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getProductListInProgress = false;
    }

    update();
    return isSuccess;
  }

  Future<void> refreshProductList(String categoryId) async {
    _currentPage = 0;
    getProductListByCategory(categoryId);
  }
}