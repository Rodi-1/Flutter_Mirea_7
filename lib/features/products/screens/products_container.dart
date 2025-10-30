import 'package:flutter/material.dart';
import '../models/product.dart';

// Экраны
import 'home_screen.dart';
import 'product_list_screen.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'coffee_gallery_screen.dart';
import 'about_screen.dart';

// Фиксированная вместимость склада
const int kWarehouseCapacity = 50;

/// Контейнер: единый источник данных + страничная навигация (Navigator)
class ProductsContainer extends StatefulWidget {
  const ProductsContainer({super.key});

  @override
  State<ProductsContainer> createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  final _navKey = GlobalKey<NavigatorState>();

  final List<Product> _items = [
    Product(
      id: Product.newId(),
      name: 'Ноутбук Acer Aspire 5',
      sku: 'AC-A515',
      qty: 12,
      location: 'A-01',
      createdAt: DateTime.now(),
    ),
    Product(
      id: Product.newId(),
      name: 'Монитор LG 24"',
      sku: 'LG-24FHD',
      qty: 7,
      location: 'B-12',
      createdAt: DateTime.now(),
    ),
    Product(
      id: Product.newId(),
      name: 'Клавиатура механическая',
      sku: 'KB-MECH',
      qty: 25,
      location: 'C-03',
      createdAt: DateTime.now(),
    ),
  ];

  // ---------- Бизнес-операции ----------
  void _createProduct({
    required String name,
    required String sku,
    required int qty,
    required String location,
  }) {
    final p = Product(
      id: Product.newId(),
      name: name.trim(),
      sku: sku.trim(),
      qty: qty.clamp(0, 1 << 31),
      location: location.trim(),
      createdAt: DateTime.now(),
    );
    setState(() => _items.add(p));
    _snack('Товар добавлен');
  }

  void _updateProduct({
    required String id,
    required String name,
    required String sku,
    required int qty,
    required String location,
  }) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    setState(() {
      _items[idx] = _items[idx].copyWith(
        name: name.trim(),
        sku: sku.trim(),
        qty: qty.clamp(0, 1 << 31),
        location: location.trim(),
      );
    });
    _snack('Изменения сохранены');
  }

  void _deleteProduct(String id) {
    setState(() => _items.removeWhere((e) => e.id == id));
    _snack('Товар удалён');
  }

  void _adjustQty(String id, int delta) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    final curr = _items[idx];
    final nextQty = (curr.qty + delta).clamp(0, 1 << 31);
    setState(() => _items[idx] = curr.copyWith(qty: nextQty));
  }

  void _snack(String msg) {
    final ctx = _navKey.currentContext;
    if (ctx == null) return;
    ScaffoldMessenger.of(ctx).clearSnackBars();
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------- Горизонтальная навигация (замена текущей страницы) ----------
  void _goHome()      => _navKey.currentState!.pushReplacement(_page(_buildHome()));
  void _goList()      => _navKey.currentState!.pushReplacement(_page(_buildList()));
  void _goGallery()   => _navKey.currentState!.pushReplacement(_page(_buildGallery()));
  void _goAbout()     => _navKey.currentState!.pushReplacement(_page(_buildAbout()));

  // ---------- Вертикальная навигация (stack) для Add/Edit ----------
  Future<void> _openAdd() async {
    await _navKey.currentState!.push(MaterialPageRoute(
      builder: (_) => AddProductScreen(
        onCancel: () => _navKey.currentState!.pop(),
        onSave: ({required name, required sku, required qty, required location}) {
          _createProduct(name: name, sku: sku, qty: qty, location: location);
          _navKey.currentState!.pop(); // вернуться на список/домой
        },
      ),
    ));
  }

  Future<void> _openEdit(String id) async {
    final p = _items.firstWhere((e) => e.id == id);
    await _navKey.currentState!.push(MaterialPageRoute(
      builder: (_) => EditProductScreen(
        initial: p,
        onCancel: () => _navKey.currentState!.pop(),
        onSave: (name, sku, qty, location) {
          _updateProduct(id: p.id, name: name, sku: sku, qty: qty, location: location);
          _navKey.currentState!.pop(); // вернуться на список
        },
      ),
    ));
  }

  // ---------- Строители экранов (с проброшенными колбэками) ----------
  Widget _buildHome() => HomeScreen(
        capacity: kWarehouseCapacity,
        usedPlaces: _items.length,
        onOpenList: _goList,                 // горизонтальная
        onOpenAdd: _openAdd,                 // ВЕРТИКАЛЬНАЯ
        onOpenGallery: _goGallery,           // горизонтальная
        onOpenAbout: _goAbout,               // горизонтальная
      );

  Widget _buildList() => ProductListScreen(
        items: _items,
        onBack: _goHome,                     // горизонтальная
        onAddTap: _openAdd,                  // ВЕРТИКАЛЬНАЯ
        onDelete: _deleteProduct,
        onAdjustQty: _adjustQty,
        onEdit: _openEdit,                   // ВЕРТИКАЛЬНАЯ
      );

  Widget _buildGallery() => CoffeeGalleryScreen(
        onBack: _goHome,                     // горизонтальная
      );

  Widget _buildAbout() => AboutScreen(
        onBack: _goHome,                     // горизонтальная
      );

  // ---------- Вспомогательное ----------
  MaterialPageRoute _page(Widget child) =>
      MaterialPageRoute(builder: (_) => child);

  @override
  Widget build(BuildContext context) {
    // Внешний Scaffold общий; заголовок можно сделать фиксированным
    return Scaffold(
      appBar: AppBar(title: const Text('Склад — приложение')),
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => _page(_buildHome()), // стартовая страница
      ),
    );
  }
}
