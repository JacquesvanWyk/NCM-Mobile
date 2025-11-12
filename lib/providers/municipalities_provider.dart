import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/api_service.dart';
import '../data/models/user_model.dart';
import 'visits_provider.dart';

final municipalitiesListProvider = FutureProvider<List<MunicipalityModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final apiService = ApiService(dio);

  return await apiService.getMunicipalities();
});
