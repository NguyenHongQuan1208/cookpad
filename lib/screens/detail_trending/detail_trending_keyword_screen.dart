import 'package:cooking_pad/screens/detail_trending/widget/custom_detail_header.dart';
import 'package:flutter/material.dart';

class DetailKeywordsScreen extends StatelessWidget {
  const DetailKeywordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomDetailHeader(
            keywordTitle: 'Detail Keywords',
            onFilterPressed: () {
              // TODO: mở bottom sheet / dialog filter
            },
            onChanged: (value) {},
          ),

          /// Body content
          const Expanded(
            child: Center(
              child: Text(
                'Detail Keywords Screen',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
