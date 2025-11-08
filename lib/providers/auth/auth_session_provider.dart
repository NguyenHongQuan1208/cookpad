import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authSessionProvider = StreamProvider<Session?>((ref) {
  final supabase = Supabase.instance.client;
  final controller = StreamController<Session?>();

  controller.add(supabase.auth.currentSession);

  final sub = supabase.auth.onAuthStateChange.listen((data) {
    controller.add(data.session);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
