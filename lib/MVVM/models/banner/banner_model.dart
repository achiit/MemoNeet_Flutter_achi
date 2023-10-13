import 'dart:convert';

List<BannersModel> bannersModelFromJson(String str) => List<BannersModel>.from(json.decode(str).map((x) => BannersModel.fromJson(x)));
String bannersModelToJson(List<BannersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannersModel {
  String image;
  String link;

  BannersModel({required this.image, required this.link});

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
        image: json["image"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "link": link,
      };
}
