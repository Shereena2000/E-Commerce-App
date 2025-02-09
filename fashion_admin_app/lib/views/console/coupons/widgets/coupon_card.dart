import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/coupon_model.dart';
import 'package:fashion_admin_app/views/console/coupons/widgets/add_modify_coupon.dart';
import 'package:fashion_admin_app/widgets/additional_confirm.dart';
import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final String  code, discription,id;
 final int discount;
  const CouponCard({
    super.key,
    required this.coupons,
    required this.discount,
    required this.code,
    required this.discription,
    required this.id,
  });

  final List<CouponModel> coupons;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: beigeColor,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorTheme,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('$discount%',
              style: const TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ),
        title: Text(code),
        subtitle: Text(discription),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AdditionalConfirm(
                    contentText: "Delete cannot be undone",
                    onNo: () => Navigator.pop(context),
                    onYes: () {
                      DbService().deleteCouponCode(docId:id );
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ModifyCoupon(
                    id: id,
                    code: code,
                    desc: discription,
                    discount: discount,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
