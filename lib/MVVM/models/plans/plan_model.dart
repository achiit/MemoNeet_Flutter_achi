class PlansModel {
  String planType;
  String subject;
  double price;
  String displayPrice;

  PlansModel(
      {required this.planType,
      required this.subject,
      required this.price,
      this.displayPrice = "n/a"});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan_type'] = planType;
    data['subject'] = subject;
    data['price'] = price;
    return data;
  }
}
