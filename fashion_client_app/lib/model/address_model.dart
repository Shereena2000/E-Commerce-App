import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String pinCode;
  final String state;
  final String? addressLabel;

  AddressModel({
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
 factory AddressModel.fromJson(Map<String, dynamic> json, String id) {
  return AddressModel(
    id: id,
    name: json["name"] ?? "User",
    address: json["address"] ?? "",
    phone: json["phoneNumber"] ?? "",
    email: json["email"] ?? "",
    pinCode: json["pinCode"] ?? "",
    state: json["state"] ?? "",
    addressLabel: json["addresslabel"] ?? "", // Ensure correct field name
  );
}


  // Convert a list of QueryDocumentSnapshot to List<SavedDetailsModel>
  static List<AddressModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list.map((e) => AddressModel.fromJson(e.data() as Map<String, dynamic>, e.id)).toList();
  }
}
