import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/sms_provider.dart';

class SendSmsPage extends ConsumerStatefulWidget {
  const SendSmsPage({super.key});

  @override
  ConsumerState<SendSmsPage> createState() => _SendSmsPageState();
}

class _SendSmsPageState extends ConsumerState<SendSmsPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _recipientController = TextEditingController();
  final _recipientNameController = TextEditingController();

  String _sendingMode = 'single'; // 'single', 'bulk'
  String _bulkRecipientType = 'members'; // 'members', 'supporters'
  String? _selectedWard;
  bool _isSending = false;

  final List<String> _wards = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
    '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _recipientController.dispose();
    _recipientNameController.dispose();
    super.dispose();
  }

  int get _characterCount => _messageController.text.length;
  int get _smsCount => (_characterCount / 160).ceil();

  Future<void> _sendSms() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_messageController.text.isEmpty) {
      _showError('Please enter a message');
      return;
    }

    setState(() => _isSending = true);

    try {
      final notifier = ref.read(smsSendingProvider.notifier);

      if (_sendingMode == 'single') {
        await notifier.sendSms(
          recipient: _recipientController.text,
          recipientName: _recipientNameController.text.isEmpty
              ? null
              : _recipientNameController.text,
          message: _messageController.text,
        );

        if (!mounted) return;
        _showSuccess('SMS sent successfully');
        _clearForm();
      } else {
        // Bulk SMS feature - Coming Soon
        if (!mounted) return;
        _showError('Bulk SMS feature coming soon. Please use single SMS for now.');
      }
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  void _clearForm() {
    _messageController.clear();
    _recipientController.clear();
    _recipientNameController.clear();
    setState(() {
      _selectedWard = null;
    });
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send SMS'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Sending Mode Selection
            _buildSendingModeCard(),
            const Gap(16),

            // Single SMS Fields
            if (_sendingMode == 'single') ...[
              _buildSingleSmsFields(),
              const Gap(16),
            ],

            // Bulk SMS Fields
            if (_sendingMode == 'bulk') ...[
              _buildBulkSmsFields(),
              const Gap(16),
            ],

            // Message Input
            _buildMessageInput(),
            const Gap(8),

            // Character Counter
            _buildCharacterCounter(),
            const Gap(24),

            // Send Button
            _buildSendButton(),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  Widget _buildSendingModeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sending Mode',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: _buildModeButton(
                    'Single SMS',
                    Icons.person,
                    'single',
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _buildModeButton(
                    'Bulk SMS',
                    Icons.groups,
                    'bulk',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(String label, IconData icon, String mode) {
    final isSelected = _sendingMode == mode;
    return InkWell(
      onTap: () => setState(() => _sendingMode = mode),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[700],
              size: 20,
            ),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleSmsFields() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recipient Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            TextFormField(
              controller: _recipientController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '0123456789',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!RegExp(r'^[0-9+]{10,13}$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            const Gap(16),
            TextFormField(
              controller: _recipientNameController,
              decoration: const InputDecoration(
                labelText: 'Recipient Name (Optional)',
                hintText: 'John Doe',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulkSmsFields() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bulk Recipients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            DropdownButtonFormField<String>(
              value: _bulkRecipientType,
              decoration: const InputDecoration(
                labelText: 'Recipient Type',
                prefixIcon: Icon(Icons.group),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'members',
                  child: Text('Members'),
                ),
                DropdownMenuItem(
                  value: 'supporters',
                  child: Text('Supporters'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _bulkRecipientType = value);
                }
              },
            ),
            const Gap(16),
            DropdownButtonFormField<String>(
              value: _selectedWard,
              decoration: const InputDecoration(
                labelText: 'Filter by Ward (Optional)',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('All Wards'),
                ),
                ..._wards.map((ward) => DropdownMenuItem(
                  value: ward,
                  child: Text('Ward $ward'),
                )),
              ],
              onChanged: (value) {
                setState(() => _selectedWard = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return TextFormField(
      controller: _messageController,
      decoration: const InputDecoration(
        labelText: 'Message',
        hintText: 'Type your message here...',
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      maxLines: 6,
      maxLength: 480,
      onChanged: (_) => setState(() {}),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a message';
        }
        if (value.length > 480) {
          return 'Message too long (max 480 characters)';
        }
        return null;
      },
    );
  }

  Widget _buildCharacterCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$_smsCount SMS ($_characterCount characters)',
          style: TextStyle(
            fontSize: 14,
            color: _characterCount > 480 ? Colors.red : AppTheme.textSecondary,
          ),
        ),
        if (_characterCount > 160)
          Text(
            'This will be sent as multiple SMS',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isSending ? null : _sendSms,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isSending
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send),
                  const Gap(8),
                  Text(
                    _sendingMode == 'single' ? 'Send SMS' : 'Queue Bulk SMS',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
