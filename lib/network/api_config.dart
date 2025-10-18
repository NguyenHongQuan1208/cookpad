import 'package:flutter_config/flutter_config.dart';

class ApiConfig {
  static String get supabaseUrl => FlutterConfig.get('API_URL');
  static String get supabaseKey => FlutterConfig.get('API_ANON_KEY');
}
