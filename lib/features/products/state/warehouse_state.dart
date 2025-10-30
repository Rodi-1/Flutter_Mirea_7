import '../models/product.dart';

/// Единое состояние приложения (без провайдеров; достаточно для учебного проекта)
class WarehouseState {
  WarehouseState._();
  static final instance = WarehouseState._();

  int capacity = 50;

  final List<Product> items = [
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

  // CRUD-операции
  void createProduct({
    required String name,
    required String sku,
    required int qty,
    required String location,
  }) {
    items.add(Product(
      id: Product.newId(),
      name: name.trim(),
      sku: sku.trim(),
      qty: qty.clamp(0, 1 << 31),
      location: location.trim(),
      createdAt: DateTime.now(),
    ));
  }

  void updateProduct({
    required String id,
    required String name,
    required String sku,
    required int qty,
    required String location,
  }) {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    items[idx] = items[idx].copyWith(
      name: name.trim(),
      sku: sku.trim(),
      qty: qty.clamp(0, 1 << 31),
      location: location.trim(),
    );
  }

  void deleteProduct(String id) {
    items.removeWhere((e) => e.id == id);
  }

  void adjustQty(String id, int delta) {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    final current = items[idx];
    items[idx] = current.copyWith(
      qty: (current.qty + delta).clamp(0, 1 << 31),
    );
  }

  Product? findById(String id) {
    try {
      return items.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
