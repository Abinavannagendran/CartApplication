import 'package:cart/CartPage.dart';
import 'package:cart/CartPageController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartPageController()),
      ],
      child: new MaterialApp(
          title: 'Cart',
          debugShowCheckedModeBanner: true,
          home: new CartPage()),
    );
  }
}
