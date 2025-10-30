/// Иммутабельная модель товара
class Product {
  final String id;
  final String name;
  final String sku;
  final int qty;
  final String location;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.qty,
    required this.location,
    required this.createdAt,
  });

  static int _auto = 0;


  static String newId() {
    final t = DateTime.now().microsecondsSinceEpoch;
    return 'p_${t}_${_auto++}';
  }

  Product copyWith({
    String? id,
    String? name,
    String? sku,
    int? qty,
    String? location,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      qty: qty ?? this.qty,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
