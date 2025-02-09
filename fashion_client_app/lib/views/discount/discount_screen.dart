import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/coupon_model.dart';
import 'package:flutter/material.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Discount Coupons",
            style: headlineText,
          ),
          scrolledUnderElevation: 0,
          forceMaterialTransparency: true,
        ),
        body: StreamBuilder(
            stream: DbService().readDiscounts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CouponModel> discounts =
                    CouponModel.fromJsonList(snapshot.data!.docs)
                        as List<CouponModel>;

                if (discounts.isEmpty) {
                  return SizedBox();
                } else {
                  return ListView.builder(
                      itemCount: discounts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.discount_outlined),
                          title: Text(discounts[index].code),
                          subtitle: Text(discounts[index].desc),
                        );
                      });
                }
              } else {
                return const SizedBox();
              }
            }));
  }
}
