class PaymentMethod {
  final int id;
  final String payment;
  // final String logo;

  PaymentMethod({
    required this.id,
    required this.payment,
    // required this.logo,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      payment: json['payment'],
      // logo: json['logo'],
    );
  }
}

class PaymentMethodList {
  final List<PaymentMethod> paymentMethodList;

  PaymentMethodList({required this.paymentMethodList});

  factory PaymentMethodList.fromJson(Map<String, dynamic> json) {
    List<PaymentMethod> paymentMethodList = [];
    for (var item in json['payment_methods']) {
      paymentMethodList.add(PaymentMethod.fromJson(item));
    }
    return PaymentMethodList(paymentMethodList: paymentMethodList);
  }
}

