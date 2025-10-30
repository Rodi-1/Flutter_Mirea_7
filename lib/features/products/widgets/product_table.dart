import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_row.dart';

/// Таблица/список товаров
class ProductTable extends StatelessWidget {
  final List<Product> items;
  final void Function(String id) onDelete;
  final void Function(String id, int delta) onAdjustQty;
  final void Function(String id) onEdit;

  const ProductTable({
    super.key,
    required this.items,
    required this.onDelete,
    required this.onAdjustQty,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Пока нет позиций'));
    }
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final p = items[index];
        return ProductRow(
          key: ValueKey(p.id), 
          product: p,
          onDelete: onDelete,
          onAdjustQty: onAdjustQty,
          onEdit: onEdit,
        );
      },
    );
  }
}
