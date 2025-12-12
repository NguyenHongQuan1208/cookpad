import 'package:cooking_pad/screens/home/widget/trending_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class TrendingSectionWidget extends HookWidget {
  const TrendingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingItems = [1, 2, 3, 4, 5, 6];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Keywords',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Updated 10:00',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 6),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 2,
            ),
            itemCount: trendingItems.length,
            itemBuilder: (context, index) {
              final itemNumber = trendingItems[index];
              return TrendingItemWidget(
                title: 'Trending Item $itemNumber',
                onTap: () {
                  print('Tapped on item: $itemNumber');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
