import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/shop/products.dart';
import 'package:fofo_app/models/shop/variation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/shop/getProductById.dart';

class ShopProvider extends ChangeNotifier {
  Map? products;
  Map? product;
  List cart = [];

  DioClient dioClient = DioClient(Dio());
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    notifyListeners();
    // print('logged');
  }

  Future getProducts(BuildContext context,
      {String? search, String? nextPage}) async {
    var endpoint = "product/lists";
    if (search != null) {
      endpoint = "$endpoint?search=$search";
    }
    if (nextPage != null) {
      print(nextPage);
      endpoint = "$endpoint?page=$nextPage";
    }
    try {
      Response response = await dioClient.get(context, endpoint);
      print('get products data');
      print(response.data);
      products = response.data;
      print(products);
      notifyListeners();
      return products;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future postReview(
      BuildContext context, String id, int rating, String comment) async {
    try {
      Response response = await dioClient.post(
          context, "product/" + id + "/review",
          data: {"comment": comment, "rating": rating});
      print('gg');
      print(response.data);
      var hold = response.data;
      return hold;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future canUserReview(BuildContext context, String id) async {
    try {
      Response response =
          await dioClient.get(context, "product/" + id + "/can-review-product");

      print('can user review');

      // Map data = response.data;
      print(response.data);
      notifyListeners();
      return response.data;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getProduct(BuildContext context, String id) async {
    try {
      Response response =
          await dioClient.get(context, "product/" + id + "/product");

      print('get single product');

      product = response.data;
      print(product);
      notifyListeners();
      return product;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future reduceOrRemoveFromCart(product) async {
    await init();
    print(cart);
    print('remm');
    cart.removeWhere((item) => item['id'] == product['id']);

    notifyListeners();
    print(cart);
    _preferences.setString('TB_CART', jsonEncode(cart));
    return {"status": true, "msg": "Cart updated successfully"};
  }

  Future addToCart(product, quantity, color, variation) async {
    await init();
    String? sCart = _preferences.getString('TB_CART');
    String msg = "Product added to cart successfully";
    bool exist = false;
    product['color'] = color.toString();
    product['variation'] = variation;
    if (sCart == null) {
      product['quantity'] = quantity;
      cart.add(product);
    } else {
      cart = jsonDecode(sCart);
      cart.forEach((element) {
        if (element['id'] == product['id']) {
          element['quantity'] = quantity;
          msg = "Cart updated successfully";
          exist = true;
        }
      });

      if (!exist) {
        product['quantity'] = quantity;
        cart.add(product);
      }
    }
    notifyListeners();
    _preferences.setString('TB_CART', jsonEncode(cart));
    // getCart();
    print(product);
    print('printi cart local');
    print(_preferences.getString('TB_CART'));
    return {"status": true, "msg": msg};
  }

  Future getCart() async {
    await init();
    print('a geting cart');
    String? sCart = _preferences.getString('TB_CART');
    if (sCart != null) {
      cart = jsonDecode(sCart);
    }
    notifyListeners();
  }

  void clearCart() {
    cart = [];
    notifyListeners();

    _preferences.setString('TB_CART', jsonEncode(cart));
    print('clear cart');
  }

  Future checkout(BuildContext context,
      {country, city, address, postalCode}) async {
    List products = [];
    double total = 0;
    cart.map((item) {
      Map hold = {
        'productId': item['id'],
        'name': item['name'],
        'qty': item['quantity'],
        'price': item['variation']['price'],
        'size': item['variation']['size'],
        'color': item['color']
      };
      total += item['variation']['price'];
      products.add(hold);
    });

    Map shipping = {
      "address": address,
      "city": city,
      "postalCode": postalCode,
      "country": country,
      "paymentMethod": "Stripe"
    };

    Map details = {
      "orderItems": products,
      "shippingAddress": shipping,
      "taxPrice": 0,
      "shippingPrice": 0,
      "itemsPrice": total,
      "totalPrice": total,
      "action": "shop"
    };
    print('checkout tt');
    print(details);
    // try {
    //   print('save checkoiut api');
    //   Response response = await dioClient
    //       .post(context, "stripe/order-checkout", data: {"product": details});
    //   print('jjfj');
    //   print(response.data);
    //   // products = response.data;
    //   // print(products);
    //   notifyListeners();
    //   return products;
    // } catch (err) {
    //   showNotification(context, false, err);
    //   notifyListeners();
    // }
  }
}
