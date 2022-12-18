import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/shop/products.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/shop/getProductById.dart';

class ShopProvider extends ChangeNotifier {
  Products? products;
  GetProductById? product;

  DioClient dioClient = DioClient(Dio());
  Future getProducts(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "product/lists");
      print('get products data');
      print(response.data);
      products = Products.fromMap(response.data);
      print(products);
      notifyListeners();
      return products;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getProduct(BuildContext context, String id) async {
    try {
      Response response =
          await dioClient.get(context, "product/" + id + "/product");

      print('get single course');

      product = GetProductById.fromMap(response.data);
      print(product);
      notifyListeners();
      return product;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }
}
