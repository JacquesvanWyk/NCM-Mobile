class Payment {
  final int id;
  final String amount;
  final String currency;
  final String description;
  final String status;
  final DateTime createdAt;
  final String reference;
  final int? yearsCovered;

  Payment({
    required this.id,
    required this.amount,
    required this.currency,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.reference,
    this.yearsCovered,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    final yearsCovered = json['years_covered'] as int?;
    return Payment(
      id: json['id'],
      amount: json['amount']?.toString() ?? '0.00',
      currency: json['currency'] ?? 'ZAR',
      description: json['description'] ??
          (yearsCovered != null ? 'NCM Membership - $yearsCovered year${yearsCovered > 1 ? 's' : ''}' : 'Membership Payment'),
      status: json['status'] ?? 'unknown',
      createdAt: DateTime.parse(json['created_at']),
      reference: json['reference'] ?? json['payment_reference'] ?? '',
      yearsCovered: yearsCovered,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'currency': currency,
        'description': description,
        'status': status,
        'created_at': createdAt.toIso8601String(),
        'reference': reference,
        'years_covered': yearsCovered,
      };
}
