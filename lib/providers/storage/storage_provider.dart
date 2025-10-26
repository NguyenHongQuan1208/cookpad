import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageNotifier extends StateNotifier<bool> {
  StorageNotifier() : super(false) {
    _loadFlag();
  }

  void setShown() async {
    state = true;
    await _saveFlag();
  }

  void reset() async {
    state = false;
    await _saveFlag();
  }

  Future<void> _saveFlag() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isShowOnboard', state);
  }

  Future<void> _loadFlag() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isShowOnboard') ?? false;
  }
}

final storageProvider = StateNotifierProvider<StorageNotifier, bool>((ref) {
  return StorageNotifier();
});
