
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/model/promo_model.dart';

class HomeService {
  final List<String> categoryOrder = ["Women", "Men", "Kids"];

  Future<Map<String, List<PromoModel>>> fetchPromosByCategory() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("shop_promos")
        .get();

    final List<PromoModel> promos = PromoModel.fromJsonList(snapshot.docs);

    // Group promos by category
    final Map<String, List<PromoModel>> groupedPromos = {};
    for (var promo in promos) {
      if (!groupedPromos.containsKey(promo.category)) {
        groupedPromos[promo.category] = [];
      }
      groupedPromos[promo.category]!.add(promo);
    }

    // Sort categories based on the defined order
    final Map<String, List<PromoModel>> sortedGroupedPromos = {};
    for (var category in categoryOrder) {
      if (groupedPromos.containsKey(category)) {
        sortedGroupedPromos[category] = groupedPromos[category]!;
      }
    }

    return sortedGroupedPromos;
  }
}