import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/api_service.dart';
import 'visits_provider.dart';

// SMS History provider
final smsHistoryProvider = StateNotifierProvider<SmsHistoryNotifier, AsyncValue<PaginatedResponse<SmsLogModel>>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SmsHistoryNotifier(apiService);
});

class SmsHistoryNotifier extends StateNotifier<AsyncValue<PaginatedResponse<SmsLogModel>>> {
  final ApiService _apiService;
  int _currentPage = 1;
  String? _statusFilter;

  SmsHistoryNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadHistory();
  }

  Future<void> loadHistory({String? status}) async {
    try {
      state = const AsyncValue.loading();
      _currentPage = 1;
      _statusFilter = status;

      final response = await _apiService.getSmsLogs(
        _currentPage,
        status: _statusFilter,
        perPage: 20,
      );
      state = AsyncValue.data(response);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> loadMoreHistory() async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.currentPage >= currentState.lastPage) {
      return;
    }

    try {
      _currentPage++;
      final response = await _apiService.getSmsLogs(
        _currentPage,
        status: _statusFilter,
        perPage: 20,
      );

      state.whenData((current) {
        final updatedLogs = [...current.data, ...response.data];
        state = AsyncValue.data(
          PaginatedResponse<SmsLogModel>(
            data: updatedLogs,
            currentPage: response.currentPage,
            perPage: response.perPage,
            total: response.total,
            lastPage: response.lastPage,
          ),
        );
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadHistory(status: _statusFilter);
  }

  Future<void> filterByStatus(String? status) async {
    await loadHistory(status: status);
  }

  List<SmsLogModel> searchLogs(String query) {
    return state.whenData((response) {
      if (query.isEmpty) return response.data;

      final lowerQuery = query.toLowerCase();
      return response.data.where((log) {
        return log.recipient.contains(query) ||
               (log.recipientName?.toLowerCase().contains(lowerQuery) ?? false) ||
               log.messageContent.toLowerCase().contains(lowerQuery);
      }).toList();
    }).valueOrNull ?? [];
  }
}

// SMS Stats provider
final smsStatsProvider = FutureProvider<SmsStatsResponse>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getSmsStats();
});

// SMS Sending provider
final smsSendingProvider = StateNotifierProvider<SmsSendingNotifier, AsyncValue<void>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SmsSendingNotifier(apiService, ref);
});

class SmsSendingNotifier extends StateNotifier<AsyncValue<void>> {
  final ApiService _apiService;
  final Ref _ref;

  SmsSendingNotifier(this._apiService, this._ref) : super(const AsyncValue.data(null));

  Future<SendSmsResponse> sendSms({
    required String recipient,
    String? recipientName,
    required String message,
  }) async {
    try {
      state = const AsyncValue.loading();

      final request = SendSmsRequest(
        recipient: recipient,
        recipientName: recipientName,
        message: message,
      );

      final response = await _apiService.sendSms(request);

      state = const AsyncValue.data(null);

      // Refresh history after successful send
      _ref.read(smsHistoryProvider.notifier).refresh();
      _ref.invalidate(smsStatsProvider);

      return response;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> sendBulkSms({
    required String message,
    required List<String> recipients,
    required List<String> recipientNames,
  }) async {
    try {
      state = const AsyncValue.loading();

      // Send multiple individual SMS messages
      int successCount = 0;
      int failCount = 0;

      for (int i = 0; i < recipients.length; i++) {
        try {
          final request = SendSmsRequest(
            recipient: recipients[i],
            recipientName: i < recipientNames.length ? recipientNames[i] : null,
            message: message,
          );

          await _apiService.sendSms(request);
          successCount++;
        } catch (e) {
          failCount++;
        }
      }

      state = const AsyncValue.data(null);

      // Refresh history and stats after bulk send
      _ref.read(smsHistoryProvider.notifier).refresh();
      _ref.invalidate(smsStatsProvider);

      if (failCount > 0) {
        throw Exception('Sent $successCount SMS successfully, $failCount failed');
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  void resetState() {
    state = const AsyncValue.data(null);
  }
}
