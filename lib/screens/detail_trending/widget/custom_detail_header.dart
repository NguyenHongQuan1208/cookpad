import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_search_box.dart';

class CustomDetailHeader extends StatelessWidget {
  final String? keywordTitle;
  final VoidCallback? onFilterPressed;
  final ValueChanged<String>? onChanged;

  const CustomDetailHeader({
    super.key,
    this.keywordTitle,
    this.onFilterPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: [
            /// Back button
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            const SizedBox(width: 12),

            /// Search box
            Expanded(
              child: CustomSearchBox(
                hintText: keywordTitle,
                onChanged: onChanged,
              ),
            ),

            const SizedBox(width: 12),

            /// Filter button
            InkWell(
              onTap: onFilterPressed,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.tune),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
