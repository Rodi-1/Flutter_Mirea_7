import 'package:flutter/material.dart';
import '../models/product.dart';
import 'home_screen.dart';
import 'product_list_screen.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'coffee_gallery_screen.dart';
import 'about_screen.dart';



const int kWarehouseCapacity = 50;

enum _Screen { home, list, add, edit, gallery, about }

/// Контейнер-фича: хранит состояние, управляет навигацией между экранами.
class ProductsContainer extends StatefulWidget {
  const ProductsContainer({super.key});

  @override
  State<ProductsContainer> createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  _Screen _screen = _Screen.home;
  String? _editingId;


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

  // --- CRUD и бизнес-логика ---

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
    _showList();
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
    final next = _items[idx].copyWith(
      name: name.trim(),
      sku: sku.trim(),
      qty: qty.clamp(0, 1 << 31),
      location: location.trim(),
    );
    setState(() => _items[idx] = next);
    _snack('Изменения сохранены');
    _showList();
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

  // --- Навигация ---

  void _showHome() => setState(() => _screen = _Screen.home);
  void _showList() => setState(() => _screen = _Screen.list);
  void _showAdd() => setState(() => _screen = _Screen.add);
  void _showEdit(String id) => setState(() {
        _editingId = id;
        _screen = _Screen.edit;
      });
  void _showGallery() => setState(() => _screen = _Screen.gallery);
  void _showAbout() => setState(() => _screen = _Screen.about);


  // --- Вспомогательные ---

  void _snack(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    late final Widget body;
    late final String title;

    switch (_screen) {
      case _Screen.home:
        title = 'Склад — домашний экран';
        body = HomeScreen(
          capacity: kWarehouseCapacity,
          usedPlaces: _items.length,
          onOpenList: _showList,
          onOpenAdd: _showAdd,
          onOpenGallery: _showGallery,
          onOpenAbout: _showAbout,
        );
        break;
      case _Screen.list:
        title = 'Склад — перечень товаров';
        body = ProductListScreen(
          items: _items,
          onBack: _showHome,
          onAddTap: _showAdd,
          onDelete: _deleteProduct,
          onAdjustQty: _adjustQty,
          onEdit: _showEdit,
        );
        break;
      case _Screen.add:
        title = 'Добавить товар';
        body = AddProductScreen(
          onCancel: _showList,
          onSave: _createProduct,
        );
        break;
      case _Screen.edit:
        title = 'Редактировать товар';
        final p = _items.firstWhere((e) => e.id == _editingId);
        body = EditProductScreen(
          initial: p,
          onCancel: _showList,
          onSave: (name, sku, qty, location) => _updateProduct(
            id: p.id, name: name, sku: sku, qty: qty, location: location,
          ),
        );
        break;
      case _Screen.gallery:
        title = 'Галерея кофе';
        body = CoffeeGalleryScreen(
          onBack: _showHome,
        );
        break;
      case _Screen.about:
        title = 'О приложении';
        body = AboutScreen(
          onBack: _showHome
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: _screen == _Screen.home
            ? null
            : IconButton(onPressed: _showHome, icon: const Icon(Icons.home_outlined)),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: body,
      ),
    );
  }
}