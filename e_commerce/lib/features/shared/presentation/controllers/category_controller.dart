import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/core/models/network_response.dart';
import 'package:e_commerce/core/services/network_caller.dart';
import 'package:e_commerce/features/shared/data/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int _currentPage = 0;

  int? _lastPageNo;

  final int _pageSize = 40;

  bool _getCategoryInProgress = false;

  bool _isInitialLoading = false;

  List<CategoryModel> _categoryList = [];

  String? _errorMessage;

  bool get getCategoryInProgress => _getCategoryInProgress;

  bool get isInitialLoading => _isInitialLoading;

  List<CategoryModel> get categoryList => _categoryList;

  String? get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;

    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }
    if (_currentPage == 0) {
      _categoryList.clear();
      _isInitialLoading = true;
    } else {
      _getCategoryInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.categoryList(_currentPage, _pageSize));
    if (response.isSuccess) {
      _lastPageNo = response.body!['data']['last_page'];
      List<CategoryModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(CategoryModel.fromJson(jsonData));
      }
      _categoryList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getCategoryInProgress = false;
    }

    update();
    return isSuccess;
  }

  Future<void> refreshCategoryList() async {
    _currentPage = 0;
    getCategoryList();
  }
}