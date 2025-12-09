import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/user_model.dart';

final paymentsProvider = StateNotifierProvider<PaymentsNotifier, AsyncValue<List<Payment>>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return PaymentsNotifier(apiService, auth);
});

final membershipStatusProvider = StateNotifierProvider<MembershipStatusNotifier, AsyncValue<MembershipStatus>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final auth = ref.watch(authProvider);
  return MembershipStatusNotifier(apiService, auth);
});

final paymentFlowProvider = StateNotifierProvider<PaymentFlowNotifier, PaymentFlowState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PaymentFlowNotifier(apiService);
});

final paymentRetryProvider = StateNotifierProvider<PaymentRetryNotifier, AsyncValue<bool>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PaymentRetryNotifier(apiService);
});

class PaymentsNotifier extends StateNotifier<AsyncValue<List<Payment>>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  PaymentsNotifier(this._apiService, this._auth) : super(const AsyncValue.loading()) {
    loadPayments();
  }

  Future<void> loadPayments() async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user?.member == null) {
        state = AsyncValue.error('No member access', StackTrace.current);
        return;
      }

      final response = await _apiService.getPaymentHistory(1);

      // Sort payments by date (newest first)
      final payments = response.data.map((pm) => Payment(
        id: pm.id,
        amount: pm.amount,
        currency: pm.currency,
        description: pm.description,
        status: pm.status,
        createdAt: pm.createdAt,
        reference: pm.reference,
      )).toList();

      payments.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      state = AsyncValue.data(payments);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadPayments();
  }
}

class MembershipStatusNotifier extends StateNotifier<AsyncValue<MembershipStatus>> {
  final ApiService _apiService;
  final AsyncValue<UserModel?> _auth;

  MembershipStatusNotifier(this._apiService, this._auth) : super(const AsyncValue.loading()) {
    loadMembershipStatus();
  }

  Future<void> loadMembershipStatus() async {
    try {
      state = const AsyncValue.loading();

      final user = _auth.valueOrNull;
      if (user?.member == null) {
        state = AsyncValue.error('No member access', StackTrace.current);
        return;
      }

      final member = user!.member!;

      // Get membership status from API
      final apiStatus = await _apiService.getMembershipStatus();

      // Use API values directly, with local calculation as fallback
      int? daysUntilExpiry = apiStatus.daysUntilExpiry;
      bool isExpiring = false;

      if (apiStatus.expiresAt != null) {
        final now = DateTime.now();
        final expiryDate = apiStatus.expiresAt!;
        daysUntilExpiry = expiryDate.difference(now).inDays;
        isExpiring = daysUntilExpiry <= 30 && daysUntilExpiry > 0;
      }

      // Use API's isExpired value - it's authoritative
      final isExpired = apiStatus.isExpired || !apiStatus.isPaid;

      final membershipStatus = MembershipStatus(
        status: apiStatus.status,
        expiresAt: apiStatus.expiresAt,
        daysUntilExpiry: daysUntilExpiry,
        isExpiring: isExpiring,
        isExpired: isExpired,
        membershipNumber: member.membershipNumber ?? '',
      );

      state = AsyncValue.data(membershipStatus);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadMembershipStatus();
  }
}

class PaymentFlowNotifier extends StateNotifier<PaymentFlowState> {
  final ApiService _apiService;

  PaymentFlowNotifier(this._apiService) : super(const PaymentFlowState());

  void selectPaymentOption(int years, double amount) {
    state = state.copyWith(
      selectedYears: years,
      selectedAmount: amount,
      step: PaymentFlowStep.paymentMethod,
    );
  }

  void selectPaymentMethod(String method) {
    state = state.copyWith(
      selectedPaymentMethod: method,
      step: PaymentFlowStep.confirmation,
    );
  }

  void resetFlow() {
    state = const PaymentFlowState();
  }

  Future<void> createPayment() async {
    try {
      state = state.copyWith(isProcessing: true, error: null);

      if (state.selectedYears == null ||
          state.selectedAmount == null ||
          state.selectedPaymentMethod == null) {
        throw Exception('Missing payment details');
      }

      final request = PaymentRequest(
        amount: state.selectedAmount!.toString(),
        currency: 'ZAR',
        description: 'NCM Membership - ${state.selectedYears} year${state.selectedYears! > 1 ? "s" : ""}',
        paymentMethod: state.selectedPaymentMethod!,
      );

      final response = await _apiService.createPayment(request);

      state = state.copyWith(
        isProcessing: false,
        paymentUrl: response.paymentUrl,
        step: PaymentFlowStep.redirect,
      );
    } catch (e, stack) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }
}

class PaymentRetryNotifier extends StateNotifier<AsyncValue<bool>> {
  final ApiService _apiService;

  PaymentRetryNotifier(this._apiService) : super(const AsyncValue.data(false));

  Future<void> retryPayment(int paymentId) async {
    try {
      state = const AsyncValue.loading();

      await _apiService.retryPayment(paymentId);

      state = const AsyncValue.data(true);

      // Reset state after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = const AsyncValue.data(false);
        }
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Payment flow state management
class PaymentFlowState {
  final PaymentFlowStep step;
  final int? selectedYears;
  final double? selectedAmount;
  final String? selectedPaymentMethod;
  final bool isProcessing;
  final String? paymentUrl;
  final String? error;

  const PaymentFlowState({
    this.step = PaymentFlowStep.selectOption,
    this.selectedYears,
    this.selectedAmount,
    this.selectedPaymentMethod,
    this.isProcessing = false,
    this.paymentUrl,
    this.error,
  });

  PaymentFlowState copyWith({
    PaymentFlowStep? step,
    int? selectedYears,
    double? selectedAmount,
    String? selectedPaymentMethod,
    bool? isProcessing,
    String? paymentUrl,
    String? error,
  }) {
    return PaymentFlowState(
      step: step ?? this.step,
      selectedYears: selectedYears ?? this.selectedYears,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      isProcessing: isProcessing ?? this.isProcessing,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      error: error,
    );
  }
}

enum PaymentFlowStep {
  selectOption,
  paymentMethod,
  confirmation,
  redirect,
}

class MembershipStatus {
  final String status;
  final DateTime? expiresAt;
  final int? daysUntilExpiry;
  final bool isExpiring;
  final bool isExpired;
  final String membershipNumber;

  const MembershipStatus({
    required this.status,
    this.expiresAt,
    this.daysUntilExpiry,
    required this.isExpiring,
    required this.isExpired,
    required this.membershipNumber,
  });
}