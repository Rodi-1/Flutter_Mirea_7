import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final VoidCallback onBack;

  const AboutScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Назад'),
          ),
          const SizedBox(height: 12),
          Text('О приложении', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '«Перечень товаров на складе» — учебное приложение на Flutter.\n\n'
            'Основные возможности:\n'
            '• учёт позиций (добавление, редактирование, удаление);\n'
            '• изменение количества прямо из списка;\n'
            '• домашний экран с диаграммой заполняемости;\n'
            '• экран галереи с сетевыми изображениями (кэширование).\n\n'
            'Версия: 1.0.0 (демо)\n'
            'Автор: Сортов Семён студент группы ИКБО-12-22\n',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
