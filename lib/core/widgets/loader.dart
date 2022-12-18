import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Loading extends StatelessWidget {
  String text;
  Loading({Key? key, this.text = "Loading..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator(), Text(text)],
    );
    ;
  }
}
