
import 'package:fashion_admin_app/models/promo_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/console/promotions/widgets/add_modify_promos.dart';
import 'package:fashion_admin_app/views/console/promotions/widgets/promo_card.dart';
import 'package:fashion_admin_app/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

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

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              // Web layout (Grid)
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Adjust grid count for responsiveness
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 5,
                  ),
                  itemCount: promos.length,
                  itemBuilder: (context, index) {
                    return PromoCard(promos: promos[index]);
                  },
                ),
              );
            } else {
              // Mobile layout (List)
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: promos.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 150, // Half of the web version size
                    child: PromoCard(promos: promos[index]),
                  );
                },
              );
            }
          },
        );
      }),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddModifyPromos(isUpdating: false, promoId: ""),
          );
        },
      ),
    );
  }
}
