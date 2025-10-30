import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_table.dart';

/// Экран списка: удаление, изменение количества, переход к редактированию
class ProductListScreen extends StatelessWidget {
  final List<Product> items;
  final VoidCallback onBack;
  final VoidCallback onAddTap;
  final void Function(String id) onDelete;
  final void Function(String id, int delta) onAdjustQty;
  final void Function(String id) onEdit;

  const ProductListScreen({
    super.key,
    required this.items,
    required this.onBack,
    required this.onAddTap,
    required this.onDelete,
    required this.onAdjustQty,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Домой'),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: onAddTap,
                icon: const Icon(Icons.add),
                label: const Text('Новая позиция'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ProductTable(
              items: items,
              onDelete: onDelete,
              onAdjustQty: onAdjustQty,
              onEdit: onEdit,
            ),
          ),
        ],
      ),
    );
  }
}
