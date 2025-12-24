import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/providers.dart'; // sessionControllerProvider / activeSiteProvider
import 'wp_api_client.dart';

final wpApiClientProvider = Provider<WpApiClient?>((ref) {
  final site = ref.watch(activeSiteProvider);
  if (site == null) return null;

  final client = WpApiClient(site);

  ref.onDispose(client.dispose);
  return client;
});
