// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';

// import '../../../models/library/my_library/category.dart';
// import '../../../service/library/my_library_provider.dart';

// class CategoryView extends StatelessWidget {
//   static const String route = "CategoryView";
//   const CategoryView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//      LibraryProvider libraryProvider = Provider.of<LibraryProvider>(context);
//      final categoryBookList = libraryProvider.fetchingCategoryById;
//      final List<Category> categories;
//     return Scaffold(
//       body: Center(
//         child: ListView.builder(
//           itemBuilder: itemBuilder
//           ),
//       )
//     );
//   }
// }