import 'dart:convert';

FaqsModel faqsModelFromJson(String str) => FaqsModel.fromJson(json.decode(str));

String faqsModelToJson(FaqsModel data) => json.encode(data.toJson());

class FaqsModel {
  String question;
  String details;

  FaqsModel({
    required this.question,
    required this.details,
  });

  factory FaqsModel.fromJson(Map<String, dynamic> json) => FaqsModel(
        question: json["question"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "details": details,
      };
}
