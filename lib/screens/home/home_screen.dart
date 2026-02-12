import 'package:cooking_pad/screens/home/widget/newest_section.dart';
import 'package:cooking_pad/screens/home/widget/premium_list_widget.dart';
import 'package:cooking_pad/screens/home/widget/search_bar_button.dart';
import 'package:cooking_pad/screens/home/widget/trending_section_widget.dart';
import 'package:cooking_pad/widget/app_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(isSearchScreen: true),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchBarButton(),
            ),

            const SizedBox(height: 32),

            TrendingSectionWidget(),

            const SizedBox(height: 32),

            PremiumList(),

            const SizedBox(height: 24),

            NewestSection(),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
