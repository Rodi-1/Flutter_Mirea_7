import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Экран-галерея: 5 случайных картинок кофе с кэшированием (офлайн поддержка).
class CoffeeGalleryScreen extends StatefulWidget {
  final VoidCallback onBack;

  const CoffeeGalleryScreen({super.key, required this.onBack});

  @override
  State<CoffeeGalleryScreen> createState() => _CoffeeGalleryScreenState();
}

class _CoffeeGalleryScreenState extends State<CoffeeGalleryScreen> {
  late List<String> _urls;

  @override
  void initState() {
    super.initState();
    _generateUrls();
  }

  void _generateUrls() {
    final ts = DateTime.now().microsecondsSinceEpoch;
    _urls = List.generate(
      5,
      (i) => 'https://coffee.alexflipnote.dev/random?cb=${ts + i}',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Назад'),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: _generateUrls,
                icon: const Icon(Icons.refresh),
                label: const Text('Обновить изображения'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,        // 2 колонки
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: _urls.length,
              itemBuilder: (context, index) {
                final url = _urls[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (c, _) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (c, _, __) => Container(
                      color: Colors.black12,
                      child: const Center(
                        child: Icon(Icons.wifi_off, size: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Изображения кешируются: после первого показа доступны офлайн',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
