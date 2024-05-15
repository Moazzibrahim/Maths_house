class PaymentMethod {
  final int id;
  final String payment;
  final String? description;
  final String? logo;
  final int? statue;
  final String createdAt;
  final String updatedAt;

  PaymentMethod({
    required this.id,
    required this.payment,
    this.description,
    this.logo,
    this.statue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      payment: json['payment'],
      description: json['description'],
      logo: json['logo'],
      statue: json['statue'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PaymentHistory {
  final int id;
  final int paymentMethodId;
  final int userId;
  final double price;
  final String image;
  final String module;
  final String state;
  final String? rejectedReason;
  final String? createdAt;
  final String updatedAt;
  final PaymentMethod? method;

  PaymentHistory({
    required this.id,
    required this.paymentMethodId,
    required this.userId,
    required this.price,
    required this.image,
    required this.module,
    required this.state,
    required this.updatedAt,
    this.rejectedReason,
    this.createdAt,
    this.method,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      id: json['id'],
      paymentMethodId: json['payment_method_id'] ?? -1,
      userId: json['user_id'],
      price: json['price'].toDouble(),
      image: json['image'] ?? '',
      module: json['module'],
      state: json['state'],
      rejectedReason: json['rejected_reason'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      method: json['method'] != null ? PaymentMethod.fromJson(json['method']) : null,
    );
  }
}

class PaymentHistoryList {
  final List<PaymentHistory> paymentHistoryList;

  PaymentHistoryList({required this.paymentHistoryList});

  factory PaymentHistoryList.fromJson(Map<String, dynamic> json) {
    List<PaymentHistory> paymentHistoryList = [];
    for (var item in json['paymentHestory']) {
      paymentHistoryList.add(PaymentHistory.fromJson(item));
    }
    return PaymentHistoryList(paymentHistoryList: paymentHistoryList);
  }
}
