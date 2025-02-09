import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/coupon_model.dart';
import 'package:flutter/material.dart';

class DiscountContainer extends StatelessWidget {
  const DiscountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DbService().readDiscounts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CouponModel> discounts =
                CouponModel.fromJsonList(snapshot.data!.docs)
                    as List<CouponModel>;

            if (discounts.isEmpty) {
              return SizedBox();
            } else {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/discount'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                   
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
                        children: [
                          SizedBox(),
                          Column(
                            children: [
                              Text(
                                "Use coupon : ${discounts[0].code}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor),
                              ),
                              Text(
                                discounts[0].desc,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: whiteColor),
                              ),
                            ],
                          ),SizedBox(height: 035,child:Image.asset("assets/gift.gif") ,)
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return SizedBox();
          }
        });
  }
}
