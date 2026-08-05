import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/core/network/api_client.dart';
import 'package:taskify_app/core/network/dio_provider.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);

  return ApiClient(dio);
});
