import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/library/my_library/books.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/category/fetch_category_by_id/fetch_category_by_id.dart';
import '../../models/library/my_library/category.dart';
import '../../models/library/my_library/get_book_by_id.dart';
import '../../models/library/my_library/my_library.dart';

class LibraryProvider extends ChangeNotifier {
  MyLibrary? myLibrary;
  Category? category;
  // late Books books;
  Books? books;
  GetBookById? book;

  FetchCategoryById? fetchingCategoryById;
  DioClient dioClient = DioClient(Dio());
  Future getLibrary(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "library");
      myLibrary = MyLibrary.fromMap(response.data);
      notifyListeners();
      return myLibrary;
    } catch (err) {
      print('library error');
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getBooks(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "library/books");
      print('books api');
      print(response.data);
      books = Books.fromMap(response.data);
      print('after book pass tru model');
      notifyListeners();
      return books;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future addBookToLibrary(BuildContext context, String id) async {
    try {
      print('id...' + id);
      Response response = await dioClient.patch(
          context, "library/book/" + id + "/add-book-to-library");

      notifyListeners();
      print(response.data);
      showNotification(context, true, "Book added successfully");
      return {"status": true, "message": "Book added successfully"};
    } catch (err) {
      notifyListeners();
      showNotification(context, false, err);
      return {"status": false, "message": err};
    }
  }

  Future getBook(BuildContext context, String id) async {
    try {
      print('before');
      Response response =
          await dioClient.get(context, "library/book/" + id + "/get");
      print('mine');
      print(response.data);
      book = GetBookById.fromMap(response.data);
      print('sfrr');
      print(book);
      return book;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future<FetchCategoryById?> fetchCategoryById(
      BuildContext context, String categoryId) async {
    try {
      Response response = await dioClient.get(
          context, "library/category/" + categoryId + '/get');
      final fetchId = FetchCategoryById.fromMap(response.data);
      debugPrint(fetchId.toString());
      notifyListeners();
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }

    // final _token = Provider.of<AuthProvider>(context, listen: false).token;
    //
    // final Response response = await Dio().get(
    //     'https://fofoapp.herokuapp.com/api/library/category/' +
    //         categoryId +
    //         '/get',
    //     options: Options(
    //         responseType: ResponseType.json,
    //         headers: {"Authorization": "Bearer $_token"}));
    // final fetchId = FetchCategoryById.fromMap(response.data);
    // debugPrint(fetchId.toString());
    // notifyListeners();
  }
}
