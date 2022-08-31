import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/service/auth_service/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../models/category/fetch_category_by_id/fetch_category_by_id.dart';
import '../../models/library/my_library/category.dart';
import '../../models/library/my_library/my_library.dart';

class LibraryProvider extends ChangeNotifier {
  MyLibrary? myLibrary;
 Category? category;
 FetchCategoryById? fetchingCategoryById;
  Future<MyLibrary?> getLibrary(BuildContext context) async {
    final _token = Provider.of<AuthProvider>(context, listen: false).token;
    final Response response = await Dio().get(
        'https://fofoapp.herokuapp.com/api/library',
        options: Options(
            responseType: ResponseType.json,
            headers: {"Authorization": "Bearer $_token"}));
    //     .catchError((err) {
    //   debugPrint("Fetch Libary Http Error: ${err.toString()}");
    // });
    myLibrary = MyLibrary.fromMap(response.data);
    debugPrint(myLibrary.toString());
    notifyListeners();
  }

  Future<FetchCategoryById?>fetchCategoryById(BuildContext context, String categoryId)async{
    final _token = Provider.of<AuthProvider>(context, listen: false).token;
    
    final Response response = await Dio().get(
      'https://fofoapp.herokuapp.com/api/library/category/' + categoryId + '/get',
      options: Options(
            responseType: ResponseType.json,
            headers: {"Authorization": "Bearer $_token"})
    );
   final fetchId = FetchCategoryById.fromMap(response.data);
   debugPrint(fetchId.toString());
   notifyListeners();
  }

}
