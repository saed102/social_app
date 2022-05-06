import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? myuserid = '';

List partment = [
  {
    "image": "assets/images/6.jpeg",
    "name": "Computer Science",
    "sub": [
      "Computer Programming",
      "Operation Systems",
      "Network",
      "Database Systems",
      "Digital Signal Processing"
    ]
  },
  {
    "image": "assets/images/8.jpeg",
    "name": " Information Systems",
    "sub": [
      "Liner Algebra2",
      "Liner Algebra",
      "Liner Algebra",
      "Liner Algebra",
      "last"
    ]
  },
  {
    "image": "assets/images/9.jpeg",
    "name": "multimedia ",
    "sub": [
      "Liner Algebra3",
      "Liner Algebra",
      "Liner Algebra",
      "Liner Algebra",
      "last"
    ]
  },
  {
    "image": "assets/images/10.jpeg",
    "name": "Software Engineering",
    "sub": [
      "Liner Algebra4",
      "Liner Algebra",
      "Liner Algebra",
      "Liner Algebra",
      "last"
    ]
  },
];

 void showToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

 Future navigateTo(BuildContext context, Widget widget) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
 }

 List chat_search = [];
 List user_search = [];

 void pop(context) {
  Navigator.pop(context);
 }

 void navigateAndKill(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget myDivider() => Container(
      color: Colors.grey[300],
      height: 0.2,
      width: double.infinity,
    );
