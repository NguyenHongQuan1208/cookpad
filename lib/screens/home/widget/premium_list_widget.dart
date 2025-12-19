import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'premium_list_item.dart';

class PremiumList extends HookWidget {
  const PremiumList({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumItems = useState<List<int>>([1, 2, 3]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.workspace_premium, color: Colors.amber, size: 24),
              SizedBox(width: 6),
              Text(
                'Premium',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: premiumItems.value.length,
          separatorBuilder: (_, __) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: Colors.grey),
          ),
          itemBuilder: (context, index) {
            final item = premiumItems.value[index];

            return PremiumListItem(
              item: item,
              onTap: () {
                debugPrint('Item tapped');
              },
            );
          },
        ),
      ],
    );
  }
}
