import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../state/warehouse_state.dart';
import '../widgets/product_table.dart';

class ProductListScreen extends StatefulWidget {
  final WarehouseState state;
  const ProductListScreen({super.key, required this.state});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  WarehouseState get ws => widget.state;

  void _onDelete(String id) {
    setState(() => ws.deleteProduct(id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Товар удалён')),
    );
  }

  void _onAdjustQty(String id, int delta) {
    setState(() => ws.adjustQty(id, delta));
  }

  void _onEdit(String id) {
    context.push('/edit/$id'); // ВЕРТИКАЛЬНАЯ
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> items = ws.items;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => context.go('/'), // горизонтальная
                icon: const Icon(Icons.home_outlined),
                label: const Text('Домой'),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => context.push('/add'), // ВЕРТИКАЛЬНАЯ
                icon: const Icon(Icons.add),
                label: const Text('Новая позиция'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ProductTable(
              items: items,
              onDelete: _onDelete,
              onAdjustQty: _onAdjustQty,
              onEdit: _onEdit,
            ),
          ),
        ],
      ),
    );
  }
}
