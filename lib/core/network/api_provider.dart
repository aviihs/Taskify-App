import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/core/network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});