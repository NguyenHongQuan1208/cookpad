import 'package:cooking_pad/widget/app_header.dart';
import 'package:flutter/material.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(isSearchScreen: false),
      body: const Center(
        child: Text("This is Personal Screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
