import 'package:fashion_admin_app/models/promo_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/console/promotions/widgets/add_modify_promos.dart';
import 'package:fashion_admin_app/views/console/promotions/widgets/promo_card.dart';
import 'package:fashion_admin_app/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropmotionScreen extends StatelessWidget {
  const PropmotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProviders>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<PromoModel> promos = PromoModel.fromJsonList(value.promos);
        if (promos.isEmpty) {
          return const Center(
            child: Text("Create Promos"),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          itemCount: promos.length,
          itemBuilder: (context, index) {
            return PromoCard(promos: promos[index]);
          },
        );
      }),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) =>
                  const AddModifyPromos(isUpdating: false, promoId: ""));
        },
      ),
    );
  }
}
