import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageNotifier extends StateNotifier<int> {
  StorageNotifier() : super(0) {
    _loadCounter();
  }

  void increase() async {
    state++;
    await _saveCounter();
  }

  void reset() async {
    state = 0;
    await _saveCounter();
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', state);
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt('counter') ?? 0;
  }
}

final storageProvider = StateNotifierProvider<StorageNotifier, int>((ref) {
  return StorageNotifier();
});
