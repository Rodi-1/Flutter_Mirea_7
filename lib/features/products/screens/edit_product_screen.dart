import 'package:flutter/material.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product initial;
  final VoidCallback onCancel;
  final void Function(String name, String sku, int qty, String location) onSave;

  const EditProductScreen({
    super.key,
    required this.initial,
    required this.onCancel,
    required this.onSave,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _sku;
  late final TextEditingController _qty;
  late final TextEditingController _loc;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.initial.name);
    _sku  = TextEditingController(text: widget.initial.sku);
    _qty  = TextEditingController(text: widget.initial.qty.toString());
    _loc  = TextEditingController(text: widget.initial.location);
  }

  @override
  void dispose() {
    _name.dispose();
    _sku.dispose();
    _qty.dispose();
    _loc.dispose();
    super.dispose();
  }

  String? _req(String? v) => (v == null || v.trim().isEmpty) ? 'Обязательное поле' : null;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final qtyParsed = int.tryParse(_qty.text.trim()) ?? 0;
    widget.onSave(_name.text.trim(), _sku.text.trim(), qtyParsed, _loc.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text('Редактирование товара', style: Theme.of(context).textTheme.titleLarge),
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
                  onPressed: widget.onCancel,
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
