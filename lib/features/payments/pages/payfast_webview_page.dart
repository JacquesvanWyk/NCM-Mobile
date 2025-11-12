import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayFastWebViewPage extends ConsumerStatefulWidget {
  final String paymentUrl;
  final String paymentReference;

  const PayFastWebViewPage({
    required this.paymentUrl,
    required this.paymentReference,
    super.key,
  });

  @override
  ConsumerState<PayFastWebViewPage> createState() => _PayFastWebViewPageState();
}

class _PayFastWebViewPageState extends ConsumerState<PayFastWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            _checkForRedirect(url);
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _errorMessage = 'Failed to load payment page: ${error.description}';
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkForRedirect(String url) {
    // Check if user returned from PayFast
    if (url.contains('/payment/success') || url.contains('/payfast/success')) {
      // Payment successful
      _handlePaymentSuccess();
    } else if (url.contains('/payment/cancel') || url.contains('/payfast/cancel')) {
      // Payment cancelled
      _handlePaymentCancelled();
    }
  }

  void _handlePaymentSuccess() {
    if (!mounted) return;

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment completed successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back with success result
    context.pop({'success': true, 'reference': widget.paymentReference});
  }

  void _handlePaymentCancelled() {
    if (!mounted) return;

    // Show cancellation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment was cancelled'),
        backgroundColor: Colors.orange,
      ),
    );

    // Navigate back with cancelled result
    context.pop({'success': false, 'cancelled': true});
  }

  void _handleBackButton() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Payment?'),
        content: const Text(
          'Are you sure you want to cancel this payment? You can retry later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue Payment'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop({'success': false, 'cancelled': true});
            },
            child: const Text('Cancel Payment'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          _handleBackButton();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Complete Payment'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _handleBackButton,
          ),
        ),
        body: Stack(
          children: [
            if (_errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                            _initializeWebView();
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            else
              WebViewWidget(controller: _controller),
            if (_isLoading && _errorMessage == null)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
