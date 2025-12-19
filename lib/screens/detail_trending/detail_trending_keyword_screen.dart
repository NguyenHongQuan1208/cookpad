import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailKeywordsScreen extends StatelessWidget {
  const DetailKeywordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          'Detail Keywords',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Detail Keywords Screen', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
