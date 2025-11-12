import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/api_service.dart';
import 'visits_provider.dart';

// PayFast Config Provider
final payfastConfigProvider = FutureProvider<PayFastConfigResponse>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getPayFastConfig();
});
