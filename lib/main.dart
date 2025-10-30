import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/products/state/warehouse_state.dart';
import 'features/products/screens/home_screen.dart';
import 'features/products/screens/product_list_screen.dart';
import 'features/products/screens/add_product_screen.dart';
import 'features/products/screens/edit_product_screen.dart';
import 'features/products/screens/coffee_gallery_screen.dart';
import 'features/products/screens/about_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ws = WarehouseState.instance;

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Склад — приложение')),
            body: HomeScreen(
              capacity: ws.capacity,
              usedPlaces: ws.items.length,
            ),
          ),
        ),
        GoRoute(
          path: '/list',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Склад — перечень товаров')),
            body: ProductListScreen(state: ws),
          ),
        ),
        GoRoute(
          path: '/add',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Добавить товар')),
            body: AddProductScreen(state: ws),
          ),
        ),
        GoRoute(
          path: '/edit/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final p = ws.findById(id);
            return Scaffold(
              appBar: AppBar(title: const Text('Редактировать товар')),
              body: p == null
                  ? const Center(child: Text('Товар не найден'))
                  : EditProductScreen(state: ws, initial: p),
            );
          },
        ),
        GoRoute(
          path: '/gallery',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Галерея кофе')),
            body: const CoffeeGalleryScreen(), // back через context.go('/')
          ),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('О приложении')),
            body: const AboutScreen(),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'ПР7 — Маршрутизированная навигация',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: router,
    );
  }
}
