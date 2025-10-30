import 'package:flutter/material.dart';
import '../widgets/pie_capacity.dart';

class HomeScreen extends StatelessWidget {
  final int capacity;
  final int usedPlaces;
  final VoidCallback onOpenList;
  final VoidCallback onOpenAdd;
  final VoidCallback onOpenGallery;

  const HomeScreen({
    super.key,
    required this.capacity,
    required this.usedPlaces,
    required this.onOpenList,
    required this.onOpenAdd,
    required this.onOpenGallery,
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
          Row(
            children: [
              Expanded(
                child: Card(
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
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Действия', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onOpenList,
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: const Text('Список товаров'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onOpenAdd,
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить товар'),
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onOpenGallery,
                  icon: const Icon(Icons.local_cafe_outlined),
                  label: const Text('Галерея кофе'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
