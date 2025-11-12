import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import '../config/app_config.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/visit_model.dart';
import '../data/models/user_model.dart';

// Dio instance provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = AppConfig.baseUrl;

  // Bypass SSL certificate verification for development
  if (AppConfig.isDebug) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  // Add auth interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final headers = await AuthService.getAuthHeaders();
      final token = await AuthService.getToken();
      print('DEBUG: Token: ${token?.substring(0, 20)}...');
      print('DEBUG: Headers: $headers');
      print('DEBUG: Request URL: ${options.uri}');
      options.headers.addAll(headers);
      handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        // Token expired, logout user
        await AuthService.logout();
      }
      handler.next(error);
    },
  ));

  return dio;
});

// API service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider);
  return ApiService(dio);
});

// Visits provider
final visitsProvider = StateNotifierProvider<VisitsNotifier, AsyncValue<List<VisitModel>>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return VisitsNotifier(apiService);
});

// Leaders provider
final leadersProvider = StateNotifierProvider<LeadersNotifier, AsyncValue<List<LeaderModel>>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return LeadersNotifier(apiService);
});

class VisitsNotifier extends StateNotifier<AsyncValue<List<VisitModel>>> {
  final ApiService _apiService;

  VisitsNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadVisits();
  }

  Future<void> loadVisits({
    int? fieldWorkerId,
    int? memberId,
    String? visitType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      state = const AsyncValue.loading();

      final municipalityId = await AuthService.getCurrentMunicipalityId();

      final response = await _apiService.getVisits(
        1, // page
        fieldWorkerId,
        memberId,
        municipalityId,
        visitType,
        startDate?.toIso8601String().split('T')[0],
        endDate?.toIso8601String().split('T')[0],
      );

      state = AsyncValue.data(response.data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> assignVisit(int visitId, int leaderId) async {
    try {
      final request = AssignVisitRequest(leaderId: leaderId);
      await _apiService.assignVisit(visitId, request);

      // Reload visits to get updated data
      await loadVisits();
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<VisitModel> checkInToVisit(int visitId, {
    double? latitude,
    double? longitude,
    String? notes,
  }) async {
    try {
      final request = CheckInRequest(
        latitude: latitude,
        longitude: longitude,
        notes: notes,
      );

      final updatedVisit = await _apiService.checkInToVisit(visitId, request);

      // Update the visit in state
      state.whenData((visits) {
        final updatedVisits = visits.map((visit) {
          return visit.id == visitId ? updatedVisit : visit;
        }).toList();
        state = AsyncValue.data(updatedVisits);
      });

      return updatedVisit;
    } catch (e) {
      rethrow;
    }
  }

  Future<VisitModel> checkOutFromVisit(int visitId, {
    double? latitude,
    double? longitude,
    String? notes,
    String? outcome,
    int? sentimentScore,
    String? memberSatisfaction,
    List<String>? issuesIdentified,
    bool followUpRequired = false,
  }) async {
    try {
      final request = CheckOutRequest(
        latitude: latitude,
        longitude: longitude,
        notes: notes,
        outcome: outcome,
        sentimentScore: sentimentScore,
        memberSatisfaction: memberSatisfaction,
        issuesIdentified: issuesIdentified,
        followUpRequired: followUpRequired,
      );

      final updatedVisit = await _apiService.checkOutFromVisit(visitId, request);

      // Update the visit in state
      state.whenData((visits) {
        final updatedVisits = visits.map((visit) {
          return visit.id == visitId ? updatedVisit : visit;
        }).toList();
        state = AsyncValue.data(updatedVisits);
      });

      return updatedVisit;
    } catch (e) {
      rethrow;
    }
  }

  Future<VisitModel> createVisit({
    required int memberId,
    required int leaderId,
    required String visitType,
    required DateTime visitDate,
    String? locationAddress,
    String status = 'scheduled',
  }) async {
    try {
      final municipalityId = await AuthService.getCurrentMunicipalityId();
      if (municipalityId == null) throw Exception('No municipality found');

      final request = CreateVisitRequest(
        memberId: memberId,
        leaderId: leaderId,
        municipalityId: municipalityId,
        visitType: visitType,
        visitDate: visitDate,
        locationAddress: locationAddress,
        status: status,
      );

      final newVisit = await _apiService.createVisit(request);

      // Add to state
      state.whenData((visits) {
        state = AsyncValue.data([...visits, newVisit]);
      });

      return newVisit;
    } catch (e) {
      rethrow;
    }
  }

  Future<VisitModel> createQuickVisit({
    required String name,
    required String surname,
    String? phoneNumber,
    required String address,
    required String visitType,
    required DateTime visitDate,
    required String priority,
    String? notes,
  }) async {
    try {
      final municipalityId = await AuthService.getCurrentMunicipalityId();
      if (municipalityId == null) throw Exception('No municipality found');

      final currentUser = await AuthService.getLeaderProfile();
      if (currentUser == null) throw Exception('No leader profile found');

      // Create a temporary member or use existing logic
      // For now, we'll create a visit with null memberId and store member info in notes
      final fullNotes = [
        'Quick Visit for: $name $surname',
        if (phoneNumber != null) 'Phone: $phoneNumber',
        'Address: $address',
        if (notes != null && notes.isNotEmpty) 'Notes: $notes',
      ].join('\n');

      final request = CreateVisitRequest(
        memberId: 1, // Use a temporary member ID for quick visits
        leaderId: currentUser.id,
        municipalityId: municipalityId,
        visitType: visitType,
        visitDate: visitDate,
        locationAddress: address,
        status: 'scheduled',
        summary: fullNotes, // Use summary field for our notes
      );

      final newVisit = await _apiService.createVisit(request);

      // Add to state
      state.whenData((visits) {
        state = AsyncValue.data([...visits, newVisit]);
      });

      return newVisit;
    } catch (e) {
      rethrow;
    }
  }

  // Helper methods to filter visits
  List<VisitModel> getTodayVisits() {
    return state.whenData((visits) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));

      return visits.where((visit) {
        final vDate = visit.visitDate ?? visit.scheduledDate ?? visit.actualDate;
        if (vDate == null) return false;
        final visitDate = DateTime(
          vDate.year,
          vDate.month,
          vDate.day,
        );
        return visitDate.isAtSameMomentAs(today) ||
               (visitDate.isAfter(today) && visitDate.isBefore(tomorrow));
      }).toList();
    }).valueOrNull ?? [];
  }

  List<VisitModel> getScheduledVisits() {
    return state.whenData((visits) {
      return visits.where((visit) => visit.status == 'scheduled').toList();
    }).valueOrNull ?? [];
  }

  List<VisitModel> getCompletedVisits() {
    return state.whenData((visits) {
      return visits.where((visit) => visit.status == 'completed').toList();
    }).valueOrNull ?? [];
  }

  List<VisitModel> getUnassignedVisits() {
    return state.whenData((visits) {
      return visits.where((visit) => visit.leaderId == null).toList();
    }).valueOrNull ?? [];
  }
}

class LeadersNotifier extends StateNotifier<AsyncValue<List<LeaderModel>>> {
  final ApiService _apiService;

  LeadersNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadLeaders();
  }

  Future<void> loadLeaders() async {
    try {
      state = const AsyncValue.loading();

      final municipalityId = await AuthService.getCurrentMunicipalityId();

      final response = await _apiService.getLeaders(1, municipalityId);

      state = AsyncValue.data(response.data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider for current leader visits
final currentLeaderVisitsProvider = FutureProvider<List<VisitModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final leader = await AuthService.getLeaderProfile();

  if (leader != null) {
    final response = await apiService.getVisitsByLeader(leader.id, 1);
    return response.data;
  }

  return [];
});

// Provider for visit statistics
final visitStatsProvider = FutureProvider<VisitStatsModel>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final municipalityId = await AuthService.getCurrentMunicipalityId();
  final leader = await AuthService.getLeaderProfile();

  return await apiService.getSentimentStats(
    municipalityId,
    leader?.id,
    null, // start_date
    null, // end_date
  );
});