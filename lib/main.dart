import 'package:cooking_pad/network/api_config.dart';
import 'package:cooking_pad/themeColors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: ApiConfig.supabaseUrl,
    anonKey: ApiConfig.supabaseKey,
  );

  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Cooking Pad',
      theme: ThemeData(
        colorScheme: ThemeColors.lightScheme,
        scaffoldBackgroundColor: ThemeColors.lightScheme.surface,
      ),
      darkTheme: ThemeData(
        colorScheme: ThemeColors.darkScheme,
        scaffoldBackgroundColor: ThemeColors.darkScheme.surface,
      ),
      themeMode: ThemeMode.system,
    );
  }
}
