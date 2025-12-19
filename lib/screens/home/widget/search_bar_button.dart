import 'package:cooking_pad/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SearchBarButton extends HookWidget {
  final String placeholder;

  const SearchBarButton({
    super.key,
    this.placeholder = 'Enter the ingredients',
  });

  @override
  Widget build(BuildContext context) {
    final onTap = useCallback(() {
      context.push(Routes.search);
    }, []);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                placeholder,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
