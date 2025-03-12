import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/promo_model.dart';
import 'package:fashion_admin_app/views/console/promotions/widgets/add_modify_promos.dart';
import 'package:fashion_admin_app/widgets/additional_confirm.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final PromoModel promos;
  const PromoCard({
    super.key,
    required this.promos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        color: beigeColor,
        boxShadow: [
          BoxShadow(
            color: beigeLiteShadowColor,
            blurRadius: 15,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: beigeDarkShadowColor,
            blurRadius: 15,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: FadeInImage.assetNetwork(
                  placeholder: "assets/placeholder.jpg",
                  image: promos.imageUrl == ""
                      ? "assets/placeholder.jpg"
                      : promos.imageUrl,
                  imageErrorBuilder: (context, error, StackTrace) {
                    return Image.asset(
                      "assets/placeholder.jpg",
                      fit: BoxFit.contain,
                    );
                  }),
            ),
            smallWidthSpacing,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(promos.category, style: boldText),
                  Text("Title: ${promos.title}"),
                   Text("Sub Title: ${promos.subTitle}"),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 18,
                  ),
                  onPressed: () {
                    showDeleteDialog(context);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  onPressed: () {
                    showEditDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AdditionalConfirm(
              contentText: "Are you sure you want to delete this?",
              onNo: () {
                Navigator.pop(context);
              },
              onYes: () {
                DbService().deletePromos(docId: promos.id);
                Navigator.pop(context);
              },
            ));
  }

  void showEditDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddModifyPromos(
              isUpdating: true,
              promoId: promos.id,
              title: promos.title,
              image: promos.imageUrl,
              subTitle: promos.subTitle,
              promoCategory: promos.category,
            ));
  }
}
