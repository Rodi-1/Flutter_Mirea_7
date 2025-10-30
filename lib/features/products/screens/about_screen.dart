import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          OutlinedButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home_outlined),
            label: const Text('Домой'),
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
            'Автор: студент группы …\n',
          ),
        ],
      ),
    );
  }
}
