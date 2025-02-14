
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/coupon_model.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:const CustomAppBar(title: "Discounts",),
        body: StreamBuilder(
            stream: DbService().readDiscounts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CouponModel> discounts =
                    CouponModel.fromJsonList(snapshot.data!.docs);
                      

                if (discounts.isEmpty) {
                  return const SizedBox();
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
