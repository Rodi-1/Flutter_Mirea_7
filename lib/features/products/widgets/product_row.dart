import 'package:flutter/material.dart';
import '../models/product.dart';

/// Строка товара с +/- количества, кнопками редактирования и удаления
class ProductRow extends StatelessWidget {
  final Product product;
  final void Function(String id) onDelete;
  final void Function(String id, int delta) onAdjustQty;
  final void Function(String id) onEdit;

  const ProductRow({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onAdjustQty,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory_2_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  'SKU: ${product.sku} • Ячейка: ${product.location.isEmpty ? "—" : product.location}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                tooltip: '–1',
                onPressed: () => onAdjustQty(product.id, -1),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('${product.qty}', style: Theme.of(context).textTheme.titleMedium),
              IconButton(
                tooltip: '+1',
                onPressed: () => onAdjustQty(product.id, 1),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          IconButton(
            tooltip: 'Редактировать',
            onPressed: () => onEdit(product.id),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Удалить',
            onPressed: () => onDelete(product.id),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
