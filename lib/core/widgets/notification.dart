import 'package:flutter/material.dart';

void showNotification(BuildContext context, status, message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.fixed,
    elevation: 0,
    content:
        Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          height: 60,
          decoration: BoxDecoration(
              color: status ? Color(0xFF0e6f40) : Color(0xFFC72C41),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Text(
                  message.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          )),
      Positioned(
          top: -10,
          left: 0,
          child: Image.asset(
            status ? "assets/images/checked.png" : "assets/images/close.png",
            height: 30,
          )),
    ]), //default is 4s
  );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
