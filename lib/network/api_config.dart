import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get supabaseUrl => dotenv.env['API_URL'] ?? '';
  static String get supabaseKey => dotenv.env['API_ANON_KEY'] ?? '';
}
