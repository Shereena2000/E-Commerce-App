import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/coupon_model.dart';
import 'package:fashion_admin_app/views/console/coupons/widgets/add_modify_coupon.dart';
import 'package:fashion_admin_app/views/console/coupons/widgets/coupon_card.dart';
import 'package:fashion_admin_app/widgets/custom_appbar.dart';
import 'package:fashion_admin_app/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class CouponsScreens extends StatelessWidget {
  const CouponsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Coupon"),
      body: StreamBuilder(
        stream: DbService().readCouponCode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No coupons found"),
            );
          }

          List<CouponModel> coupons =
              CouponModel.fromJsonList(snapshot.data!.docs);
                

          return ListView.builder(
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CouponCard(
                  coupons: coupons,
                  discount: coupons[index].discount,
                  code: coupons[index].code,
                  discription: coupons[index].desc,
                  id: coupons[index].id,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                const ModifyCoupon(id: "", code: "", desc: "", discount: 0),
          );
        },
      ),
    );
  }
}

