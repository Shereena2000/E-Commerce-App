import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/model/address_model.dart';
import 'package:fashion_client_app/provider/profile_provider.dart';
import 'package:fashion_client_app/views/address/widgets/build_address_card.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(title: "Address Book"),
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<AddressModel> profiles =
              AddressModel.fromJsonList(value.profiles);
        
          if (profiles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Details"),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "ADD NEW ADDRESS",
                    onPressed: () {
                      Navigator.pushNamed(context, '/addDetails');
                    },
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        print("Address Label: ${profiles[index].addressLabel}");
                      
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: BuildAddressCard(
                            id: profiles[index].id,
                            name: profiles[index].name,
                            address: profiles[index].address,
                            phone: profiles[index].phone,
                            pinCode: profiles[index].pinCode,
                            email: profiles[index].email,
                            state: profiles[index].state,
                            label: profiles[index].addressLabel,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 1.0,
                      ),
                    ),
                  ),
                  liteSpacing,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: "ADD NEW ADDRESS",
                      onPressed: () {
                        Navigator.pushNamed(context, '/addDetails');
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}