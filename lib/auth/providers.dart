import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/wp_session.dart';
import 'models/wp_site_account.dart';
import 'session_controller.dart';

// Your existing AsyncNotifier provider
final sessionControllerProvider =
    AsyncNotifierProvider<SessionController, WpSession?>(SessionController.new);

// Derived: active site (defaults to first via WpSessionX.activeSite)
final activeSiteProvider = Provider<WpSiteAccount?>((ref) {
  final sessionAsync = ref.watch(sessionControllerProvider);
  return sessionAsync.asData?.value?.activeSite;
});
