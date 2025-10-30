import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../state/warehouse_state.dart';

class AddProductScreen extends StatefulWidget {
  final WarehouseState state;
  const AddProductScreen({super.key, required this.state});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _sku = TextEditingController();
  final _qty = TextEditingController(text: '0');
  final _loc = TextEditingController();

  @override
  void dispose() {
    _name.dispose(); _sku.dispose(); _qty.dispose(); _loc.dispose();
    super.dispose();
  }

  String? _req(String? v) => (v == null || v.trim().isEmpty) ? 'Обязательное поле' : null;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.state.createProduct(
      name: _name.text.trim(),
      sku: _sku.text.trim(),
      qty: int.tryParse(_qty.text.trim()) ?? 0,
      location: _loc.text.trim(),
    );
    context.pop(); // вернуться на предыдущий экран (список/домой)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Товар добавлен')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text('Карточка товара', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Название', border: OutlineInputBorder()),
              validator: _req,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sku,
              decoration: const InputDecoration(labelText: 'SKU (артикул)', border: OutlineInputBorder()),
              validator: _req,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _qty,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Количество', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _loc,
              decoration: const InputDecoration(labelText: 'Локация/ячейка', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close),
                  label: const Text('Отмена'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Сохранить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
