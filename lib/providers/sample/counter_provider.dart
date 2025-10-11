import 'package:flutter_riverpod/legacy.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increase() => state++;

  void reset() => state = 0;
}

// Tạo provider để sử dụng CounterNotifier
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
