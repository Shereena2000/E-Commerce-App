import 'package:fashion_client_app/model/profile_model.dart';
import 'package:fashion_client_app/provider/profile_provider.dart';
import 'package:fashion_client_app/views/more/profile/widgets/build_address_card.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedDetailsScreen extends StatelessWidget {
  const SavedDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            ); 
          }
          List<ProfileModel> profiles =
              ProfileModel.fromJsonList(value.profiles);

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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profiles.length,
                    itemBuilder: (context, index) {
                      return BuildAddressCard(
                        id: profiles[index].id,
                        name: profiles[index].name,
                        address: profiles[index].address,
                        phone: profiles[index].phone,
                        pinCode: profiles[index].pinCode,
                        email: profiles[index].email,
                        state: profiles[index].state,
                        label: profiles[index].addressLabel,
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 20),
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
