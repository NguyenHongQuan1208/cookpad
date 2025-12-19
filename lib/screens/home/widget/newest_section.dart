import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'newest_item.dart';

class NewestSection extends HookWidget {
  const NewestSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = useMemoized(() => [1, 2, 3, 4, 5]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently released dishes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, size: 20),
                onPressed: () {
                  // TODO: handle see more
                },
              ),
            ],
          ),
        ),

        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return NewestItem(index: items[index]);
            },
          ),
        ),
      ],
    );
  }
}
