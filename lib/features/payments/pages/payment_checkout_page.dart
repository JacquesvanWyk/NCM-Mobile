import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../config/app_config.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/payfast_provider.dart';
import '../providers/payments_provider.dart';

class PaymentCheckoutPage extends ConsumerStatefulWidget {
  final int years;
  final double amount;

  const PaymentCheckoutPage({
    super.key,
    required this.years,
    required this.amount,
  });

  @override
  ConsumerState<PaymentCheckoutPage> createState() => _PaymentCheckoutPageState();
}

class _PaymentCheckoutPageState extends ConsumerState<PaymentCheckoutPage> {
  bool _agreedToTerms = false;
  bool _isProcessing = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (!_agreedToTerms) return;

    setState(() => _isProcessing = true);

    // Auto-scroll to show the PayFast WebView after state updates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  String _generateSignature(Map<String, String> data, String passphrase) {
    // PayFast requires parameters in a specific priority order (not alphabetical)
    const fieldOrder = [
      // Merchant Details
      'merchant_id', 'merchant_key', 'return_url', 'cancel_url', 'notify_url',
      // Buyer Details
      'name_first', 'name_last', 'email_address', 'cell_number',
      // Transaction Details
      'm_payment_id', 'amount', 'item_name', 'item_description',
      'custom_int1', 'custom_int2', 'custom_int3', 'custom_int4', 'custom_int5',
      'custom_str1', 'custom_str2', 'custom_str3', 'custom_str4', 'custom_str5',
      // Transaction Options
      'email_confirmation', 'confirmation_address',
      // Payment Method
      'payment_method',
      // Recurring Billing
      'subscription_type', 'billing_date', 'recurring_amount', 'frequency', 'cycles',
    ];

    // Filter out empty values and signature field
    final filteredData = Map<String, String>.from(data);
    filteredData.removeWhere((key, value) => key == 'signature' || value.trim().isEmpty);

    // Sort keys by priority order
    final sortedKeys = filteredData.keys.toList()
      ..sort((a, b) {
        final indexA = fieldOrder.indexOf(a);
        final indexB = fieldOrder.indexOf(b);
        // If not in priority list, put at end
        final priorityA = indexA == -1 ? 999 : indexA;
        final priorityB = indexB == -1 ? 999 : indexB;
        return priorityA.compareTo(priorityB);
      });

    // Build parameter string using quote_plus encoding (spaces become +)
    final params = sortedKeys
        .map((key) => '$key=${Uri.encodeComponent(filteredData[key]!.trim()).replaceAll('%20', '+')}')
        .join('&');

    // Add passphrase at the end ONLY if it's not empty
    final stringToHash = passphrase.isNotEmpty
        ? '$params&passphrase=${Uri.encodeComponent(passphrase)}'
        : params;

    // Generate MD5 hash
    final bytes = utf8.encode(stringToHash);
    final digest = md5.convert(bytes);

    return digest.toString();
  }

  String _buildPayFastHtml(Map<String, String> paymentData, String signature, String processUrl) {
    final formFields = paymentData.entries
        .map((entry) => '<input type="hidden" name="${entry.key}" value="${entry.value}">')
        .join('\n');

    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PayFast Payment</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            padding: 20px;
            background: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo {
            text-align: center;
            margin-bottom: 20px;
            color: #6b4423;
            font-size: 24px;
            font-weight: bold;
        }
        .payment-details {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .detail-label {
            color: #666;
        }
        .detail-value {
            font-weight: 600;
            color: #333;
        }
        .submit-button {
            width: 100%;
            padding: 16px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }
        .submit-button:hover {
            background: #218838;
        }
        .loading {
            text-align: center;
            padding: 20px;
            color: #666;
        }
        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #6b4423;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">NCM Payment</div>
        <div class="payment-details">
            <div class="detail-row">
                <span class="detail-label">Item:</span>
                <span class="detail-value">NCM Membership (${widget.years} year${widget.years > 1 ? "s" : ""})</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Amount:</span>
                <span class="detail-value">R ${widget.amount.toStringAsFixed(2)}</span>
            </div>
        </div>
        <form action="$processUrl" method="post" id="paymentForm">
            $formFields
            <input type="hidden" name="signature" value="$signature">
            <button type="submit" class="submit-button">Proceed to PayFast</button>
        </form>
        <div id="loading" class="loading" style="display:none;">
            <div class="spinner"></div>
            <p>Redirecting to PayFast...</p>
        </div>
    </div>
    <script>
        document.getElementById('paymentForm').addEventListener('submit', function() {
            document.getElementById('loading').style.display = 'block';
            this.style.display = 'none';
        });
    </script>
</body>
</html>
    ''';
  }

  Widget _buildPayFastWebView() {
    final authState = ref.watch(authProvider);
    final configAsync = ref.watch(payfastConfigProvider);

    return authState.when(
      data: (user) {
        if (user == null || user.member == null) {
          return const Center(child: Text('User not authenticated'));
        }

        return configAsync.when(
          data: (config) {
            final member = user.member!;
            final memberEmail = member.email ?? 'member@ncm.org.za';
            final reference = 'NCM-${DateTime.now().millisecondsSinceEpoch}';

            // Build payment data using config from API
            final paymentData = {
              'merchant_id': config.merchantId,
              'merchant_key': config.merchantKey,
              'return_url': AppConfig.paymentSuccessUrl,
              'cancel_url': AppConfig.paymentCancelUrl,
              'notify_url': AppConfig.paymentNotifyUrl,
              'name_first': member.name ?? 'Member',
              'name_last': member.surname ?? 'User',
              'email_address': memberEmail,
              'm_payment_id': reference,
              'amount': widget.amount.toStringAsFixed(2),
              'item_name': 'NCM Membership',
              'item_description': 'NCM Membership - ${widget.years} year${widget.years > 1 ? "s" : ""}',
            };

            // Generate signature
            final signature = _generateSignature(paymentData, config.passphrase);

            // Build HTML with form using config process URL
            final html = _buildPayFastHtml(paymentData, signature, config.processUrl);

            // Create WebView controller
            final controller = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (url) {
                    print('Page loaded: $url');
                  },
                  onNavigationRequest: (request) {
                    final url = request.url;
                    print('Navigation to: $url');

                    // Handle return URLs
                    if (url.contains('payment/success')) {
                      if (mounted) {
                        // Refresh providers to update payment status
                        ref.invalidate(authProvider);
                        ref.invalidate(membershipStatusProvider);

                        // Close page with success result
                        Navigator.of(context).pop(true);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Payment completed successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      return NavigationDecision.prevent;
                    }

                    if (url.contains('payment/cancel')) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Payment was cancelled'),
                            backgroundColor: Colors.orange,
                          ),
                        );

                        setState(() => _isProcessing = false);
                      }
                      return NavigationDecision.prevent;
                    }

                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadHtmlString(html);

            return WebViewWidget(controller: controller);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Failed to load payment config'),
                const SizedBox(height: 8),
                Text(error.toString(), style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // When processing, show full-screen WebView for PayFast
    if (_isProcessing) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('PayFast Payment'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() => _isProcessing = false);
            },
          ),
        ),
        body: _buildPayFastWebView(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Checkout'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Summary Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Membership - ${widget.years} Year${widget.years > 1 ? "s" : ""}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'R${widget.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    const Text(
                      'R10 per year',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const Gap(12),
                    const Divider(),
                    const Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'R${widget.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Gap(24),

            // Payment Method Section
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const Gap(16),

            // PayFast Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: AppTheme.primaryColor,
                      size: 32,
                    ),
                    const Gap(16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PayFast',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Gap(4),
                          Text(
                            'Secure payment via PayFast with multiple payment options',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Gap(24),

            // Security Notice
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.green.shade600,
                    size: 24,
                  ),
                  const Gap(12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secure Payment',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(4),
                        Text(
                          'Your payment is processed securely using industry-standard encryption.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Terms and Conditions
            CheckboxListTile(
              value: _agreedToTerms,
              onChanged: (value) => setState(() => _agreedToTerms = value ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'I agree to the Terms and Conditions and Privacy Policy',
                style: TextStyle(fontSize: 14),
              ),
              subtitle: const Text(
                'By proceeding with this payment, you acknowledge that you have read and agree to our terms.',
                style: TextStyle(fontSize: 12),
              ),
            ),

            const Gap(32),

            // Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agreedToTerms ? _processPayment : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Proceed to PayFast - R${widget.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
