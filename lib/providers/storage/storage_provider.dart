import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageNotifier extends StateNotifier<AsyncValue<bool>> {
  StorageNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = AsyncValue.data(prefs.getBool('isShowOnboard') ?? false);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> setShown() async {
    final prefs = await SharedPreferences.getInstance();
    state = const AsyncValue.data(true);
    await prefs.setBool('isShowOnboard', true);
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    state = const AsyncValue.data(false);
    await prefs.setBool('isShowOnboard', false);
  }
}

final storageProvider =
    StateNotifierProvider<StorageNotifier, AsyncValue<bool>>((ref) {
      return StorageNotifier();
    });
