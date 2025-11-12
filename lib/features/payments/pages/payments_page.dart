import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/payment_model.dart' show Payment;
import '../providers/payments_provider.dart';
import 'payment_checkout_page.dart';

class PaymentsPage extends ConsumerStatefulWidget {
  const PaymentsPage({super.key});

  @override
  ConsumerState<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends ConsumerState<PaymentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _retryFailedPayment(Payment payment) async {
    try {
      await ref.read(paymentRetryProvider.notifier).retryPayment(payment.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Redirecting to payment...'),
            backgroundColor: Colors.blue,
          ),
        );
      }

      // Refresh data
      ref.refresh(membershipStatusProvider);
      ref.refresh(paymentsProvider);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to retry payment: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _navigateToPayment() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => const PaymentCheckoutPage(
          years: 1,
          amount: 10.00,
        ),
      ),
    );

    // If payment was successful, refresh the membership status
    if (result == true && mounted) {
      ref.refresh(membershipStatusProvider);
      ref.refresh(paymentsProvider);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments & Membership'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Membership'),
            Tab(text: 'Payment History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMembershipTab(),
          _buildPaymentHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildMembershipTab() {
    final membershipStatusAsync = ref.watch(membershipStatusProvider);

    return membershipStatusAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const Gap(16),
            Text(
              'Failed to load membership status',
              style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
            ),
            const Gap(8),
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () => ref.refresh(membershipStatusProvider),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
      data: (membershipStatus) => _buildMembershipContent(membershipStatus),
    );
  }

  Widget _buildMembershipContent(MembershipStatus membershipStatus) {
    final isActive = !membershipStatus.isExpired;
    final paymentDue = membershipStatus.isExpired || membershipStatus.isExpiring;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Membership Status Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isActive
                            ? Icons.check_circle
                            : Icons.warning,
                        color: isActive
                            ? Colors.green
                            : Colors.orange,
                        size: 32,
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Membership Status',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              isActive
                                  ? 'Active'
                                  : 'Payment Required',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isActive
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (membershipStatus.expiresAt != null) ...[
                    const Gap(16),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 20,
                          color: AppTheme.textSecondary,
                        ),
                        const Gap(8),
                        Text(
                          'Expires: ${DateFormat('MMM dd, yyyy').format(membershipStatus.expiresAt!)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          const Gap(24),

          // Constitutional Requirement Notice
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade600,
                      size: 20,
                    ),
                    const Gap(8),
                    const Text(
                      'Constitutional Requirement',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  'Annual membership fee of R10 is required to maintain active membership status and participate in NCM activities.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          if (paymentDue) ...[
            const Gap(24),

            // Payment Due Section
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.payment,
                          color: Colors.orange.shade600,
                          size: 24,
                        ),
                        const Gap(12),
                        const Text(
                          'Payment Required',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Text(
                      'Your membership payment is due. Please make a payment to maintain your active status.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount Due',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const Gap(4),
                        const Text(
                          'R10.00',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _navigateToPayment,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Pay Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const Gap(24),

          // Benefits Section
          const Text(
            'Membership Benefits',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Gap(16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildBenefitItem(
                    Icons.how_to_vote,
                    'Voting Rights',
                    'Participate in municipal elections and community decisions',
                  ),
                  const Gap(12),
                  _buildBenefitItem(
                    Icons.event,
                    'Event Access',
                    'Attend community events and town hall meetings',
                  ),
                  const Gap(12),
                  _buildBenefitItem(
                    Icons.support_agent,
                    'Priority Support',
                    'Faster response to service requests and complaints',
                  ),
                  const Gap(12),
                  _buildBenefitItem(
                    Icons.card_membership,
                    'Digital Membership Card',
                    'Access to digital identity verification',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryTab() {
    final paymentsAsync = ref.watch(paymentsProvider);

    return paymentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const Gap(16),
            Text(
              'Failed to load payment history',
              style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
            ),
            const Gap(8),
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () => ref.refresh(paymentsProvider),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
      data: (payments) {
        if (payments.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: AppTheme.textSecondary),
                Gap(16),
                Text(
                  'No payment history',
                  style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: payments.length,
          itemBuilder: (context, index) {
            final payment = payments[index];
            return _PaymentHistoryCard(
              payment: payment,
              onRetry: payment.status == 'failed' ? () => _retryFailedPayment(payment) : null,
            );
          },
        );
      },
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 24,
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Gap(4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PaymentHistoryCard extends StatelessWidget {
  final Payment payment;
  final VoidCallback? onRetry;

  const _PaymentHistoryCard({
    required this.payment,
    this.onRetry,
  });

  Color _getStatusColor() {
    switch (payment.status) {
      case 'completed':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    switch (payment.status) {
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      case 'pending':
        return 'Pending';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'R${payment.amount}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
                const Gap(4),
                Text(
                  DateFormat('MMM dd, yyyy').format(payment.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Gap(16),
                Icon(
                  Icons.receipt,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
                const Gap(4),
                Text(
                  payment.reference,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            if (onRetry != null) ...[
              const Gap(12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onRetry,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('Retry Payment'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}