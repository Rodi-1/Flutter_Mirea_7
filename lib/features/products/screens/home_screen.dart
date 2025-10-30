import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/pie_capacity.dart';

class HomeScreen extends StatelessWidget {
  final int capacity;
  final int usedPlaces;

  const HomeScreen({
    super.key,
    required this.capacity,
    required this.usedPlaces,
  });

  @override
  Widget build(BuildContext context) {
    final clampedUsed = usedPlaces.clamp(0, capacity > 0 ? capacity : usedPlaces);
    final overfilled = usedPlaces > capacity && capacity > 0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Состояние склада', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: PieCapacity(
                      used: clampedUsed,
                      capacity: capacity == 0 ? 1 : capacity,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    overfilled
                        ? 'Позиции: $usedPlaces / $capacity (переполнение)'
                        : 'Позиции: $usedPlaces / $capacity',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Действия', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => context.go('/list'), // горизонтальная
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: const Text('Список товаров'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/add'), // ВЕРТИКАЛЬНАЯ
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить товар'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/gallery'), // горизонтальная
                  icon: const Icon(Icons.local_cafe_outlined),
                  label: const Text('Галерея кофе'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/about'), // горизонтальная
                  icon: const Icon(Icons.info_outline),
                  label: const Text('О приложении'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
