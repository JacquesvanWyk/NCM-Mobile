class Payment {
  final int id;
  final String amount;
  final String currency;
  final String description;
  final String status;
  final DateTime createdAt;
  final String reference;

  Payment({
    required this.id,
    required this.amount,
    required this.currency,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.reference,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'],
        amount: json['amount'],
        currency: json['currency'] ?? 'ZAR',
        description: json['description'] ?? '',
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        reference: json['reference'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'currency': currency,
        'description': description,
        'status': status,
        'created_at': createdAt.toIso8601String(),
        'reference': reference,
      };
}
