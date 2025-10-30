import 'package:flutter/material.dart';
import 'features/products/screens/products_container.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ПР6 — Перечень товаров на складе с интернет-картинками',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ProductsContainer(),
    );
  }
}
