import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/model/address_model.dart';

class OrdersModel {
  String id, email, name, phone, status, user_id, address;
  int discount, total, created_at;
  AddressModel addressDetails;
  List<OrderProductModel> products;

  OrdersModel({
    required this.id,
    required this.created_at,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.status,
    required this.user_id,
    required this.discount,
    required this.total,
    required this.products,
    required this.addressDetails,
  });

  // convert json to object model
  factory OrdersModel.fromJson(Map<String, dynamic> json, String id) {
    return OrdersModel(
        id: id ?? "",
        created_at: json["created_at"] ?? 0,
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        status: json["status"] ?? "",
        address: json["address"] ?? "",
        user_id: json["user_id"] ?? "",
        discount: json["discount"] ?? 0,
        total: json["total"] ?? 0,
        addressDetails: json["address_details"] is Map<String, dynamic>
            ? AddressModel.fromJson(json["address_details"], id)
            : AddressModel(
                id: id,
                name: "Unknown",
                address: json["address"] ?? "No Address Provided",
                phone: "",
                email: "",
                pinCode: "",
                state: "",
              ),
        products: List<OrderProductModel>.from(
            json["products"].map((e) => OrderProductModel.fromJson(e))));
  }

// Convert List<QueryDocumentSnapshot> to List<OrdersModel>
  static List<OrdersModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list
        .map(
            (e) => OrdersModel.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}

class OrderProductModel {
  String id, name, image, size, color;
  int quantity, single_price, total_price;

  OrderProductModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.quantity,
      required this.single_price,
      required this.total_price,
      required this.color,
      required this.size});

  //  convert json to object model
  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        size: json["size"] ?? "",
        color: json["color"] ?? "",
        image: json["image"] ?? "",
        quantity: json["quantity"] ?? 0,
        single_price: json["single_price"] ?? 0,
        total_price: json["total_price"] ?? 0);
  }
}
