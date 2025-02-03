import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String pinCode;
  final String state;
  final String? addressLabel;

  ProfileModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.pinCode,
    required this.state,
    this.addressLabel,
  });

  // Convert JSON to SavedDetailsModel
  factory ProfileModel.fromJson(Map<String, dynamic> json, String id) {
    return ProfileModel(
      id: id,
      name: json["name"] ?? "User",
      address: json["address"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      pinCode: json["pinCode"] ?? "",
      state: json["state"] ?? "",
      addressLabel: json["addressLabel"],
    );
  }

  // Convert a list of QueryDocumentSnapshot to List<SavedDetailsModel>
  static List<ProfileModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list.map((e) => ProfileModel.fromJson(e.data() as Map<String, dynamic>, e.id)).toList();
  }
}
