import 'package:flutter/material.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal", textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This is Personal Screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
