import 'package:cooking_pad/network/api_config.dart';
import 'package:cooking_pad/themeColors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

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
        colorScheme: ColorScheme(
          primary: ThemeColors.lightPrimaryColor,
          primaryContainer: ThemeColors.lightPrimaryVariant,
          secondary: ThemeColors.lightSecondaryColor,
          secondaryContainer: ThemeColors.lightSecondaryVariant,
          surface: ThemeColors.lightBackgroundColor,
          error: ThemeColors.lightErrorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: ThemeColors.lightTextPrimary,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: ThemeColors.lightBackgroundColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: ThemeColors.lightTextPrimary),
          bodyMedium: TextStyle(color: ThemeColors.lightTextPrimary),
          bodySmall: TextStyle(color: ThemeColors.lightTextSecondary),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme(
          primary: ThemeColors.darkPrimaryColor,
          primaryContainer: ThemeColors.darkPrimaryVariant,
          secondary: ThemeColors.darkSecondaryColor,
          secondaryContainer: ThemeColors.darkSecondaryVariant,
          surface: ThemeColors.darkBackgroundColor,
          error: ThemeColors.darkErrorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: ThemeColors.darkTextPrimary,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: ThemeColors.darkBackgroundColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: ThemeColors.darkTextPrimary),
          bodyMedium: TextStyle(color: ThemeColors.darkTextPrimary),
          bodySmall: TextStyle(color: ThemeColors.darkTextSecondary),
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
