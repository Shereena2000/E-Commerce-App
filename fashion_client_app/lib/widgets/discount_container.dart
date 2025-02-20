
import 'dart:async';
import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DiscountContainer extends StatefulWidget {
  const DiscountContainer({super.key});

  @override
  DiscountContainerState createState() => DiscountContainerState();
}

class DiscountContainerState extends State<DiscountContainer> {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = true; 
        });

        // Hide after 30 seconds
        Future.delayed(const Duration(minutes: 5), () {
          if (mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        });
      }
    });
  }

  void _hideWidget() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox(); // Hide when necessary

    return StreamBuilder(
      stream: DbService().readDiscounts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CouponModel> discounts =
              CouponModel.fromJsonList(snapshot.data!.docs);
          if (discounts.isEmpty) {
            return const SizedBox();
          } else {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/discount'),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
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
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Lottie.asset("assets/gift.json"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // Close Button (Top-Right)
                Positioned(
                left: 8,
                  top: 1,
                  child: GestureDetector(
                    onTap: _hideWidget, // Hide the widget when tapped
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                        border: Border.all()
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 12,
                        color: blackColor
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
